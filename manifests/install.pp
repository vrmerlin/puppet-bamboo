class bamboo::install (
  $user               = $bamboo::user,
  $group              = $bamboo::group,
  $uid                = $bamboo::uid,
  $gid                = $bamboo::gid,
  $password           = $bamboo::password,
  $homedir            = $bamboo::homedir,
  $shell              = $bamboo::shell,
  $download_url       = $bamboo::download_url,
  $installdir         = $bamboo::installdir,
  $version            = $bamboo::version,
  $appdir             = $bamboo::real_appdir,
  $extension          = $bamboo::extension,
  $manage_user        = $bamboo::manage_user,
  $manage_group       = $bamboo::manage_group,
  $manage_installdir  = $bamboo::manage_installdir,
  $manage_appdir      = $bamboo::manage_appdir,
  $stop_command       = $bamboo::stop_command,
) {

  $file    = "atlassian-bamboo-${version}.${extension}"

  if $manage_user {
    user { $user:
      ensure           => 'present',
      comment          => 'Bamboo service account',
      shell            => $shell,
      home             => $homedir,
      password         => $password,
      password_min_age => '0',
      password_max_age => '99999',
      managehome       => true,
      uid              => $uid,
      gid              => $gid,
    }
  }

  if $manage_group {
    group { $group:
      ensure => 'present',
      gid    => $gid,
    }
  }

  if $manage_installdir {
    file { $installdir:
      ensure => 'directory',
      owner  => $user,
      group  => $group,
    }
  }

  if $manage_appdir {
    file { $appdir:
      ensure => 'directory',
      owner  => $user,
      group  => $group,
      before => Archive[$file],
    }
  }

  file { $homedir:
    ensure => 'directory',
    owner  => $user,
    group  => $group,
    mode   => '0750',
  }

  archive { $file:
    path    => "/tmp/${file}",
    source  => "${download_url}/${file}",
    extract => true,
    extract_path => $installdir,
    creates => "${appdir}/conf",
    user    => $user,
    group   => $group,
  }

  #
  # If the 'bamboo_version' fact is defined (as provided by this module),
  # compare it to the specified version.  If it doesn't match, stop the
  # bamboo service prior to upgrading but after downloading the new version
  #
  if defined('$::bamboo_version') {
    if versioncmp($::bamboo::version, $::bamboo_version) > 0 {
      notify { "Updating Bamboo from version ${::bamboo_version} to ${::bamboo::version}": }
      exec { $stop_command:
        path    => $::path,
        require => Archive[$file],
      }
    }
  }


  file { "${homedir}/logs":
    ensure => 'directory',
    owner  => $user,
    group  => $group,
  }

  exec { "chown_${appdir}":
    command => "chown -R ${user}:${group} ${appdir}",
    unless  => "find ${appdir} ! -type l \\( ! -user ${user} \\) -o \\( ! -group ${group} \\) | wc -l | awk '{print \$1}' | grep -qE '^0'",
    path    => '/bin:/usr/bin',
  }

}
