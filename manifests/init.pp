# Class: bamboo
#
# This module manages Atlassian Bamboo
#
# Parameters:
#
# Actions:
#
# Requires:
#
#	Define['wget']
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class bamboo (
  $version    = '5.4.1',
  $extension  = 'tar.gz',
  $installdir = '/usr/local',
  $home       = '/var/local/bamboo',
  $user       = 'bamboo',
  $java_home  = '/usr/lib/jvm/java',
) {

  $srcdir = '/usr/local/src'
  $dir = "${installdir}/bamboo-${version}"

  $properties = $version ? {
    /^(4|5\.0)/ => "${dir}/webapp/WEB-INF/classes/bamboo-init.properties",
    default => "${dir}/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties",
  }
  
  File {
    owner  => $user,
    group  => $user,
  }

  if !defined(User[$user]) {
    user { $user:
      ensure     => present,
      home       => $home,
      managehome => false,
      system     => true,
    }
  }

  wget::fetch { 'bamboo':
    source      => "http://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-${version}.${extension}",
    destination => "${srcdir}/atlassian-bamboo-${version}.tar.gz",
    before      => Exec['bamboo'],
  }

  exec { 'bamboo':
    command   => "tar zxvf ${srcdir}/atlassian-bamboo-${version}.tar.gz && mv atlassian-bamboo-${version} bamboo-${version} && chown -R ${user} bamboo-${version}",
    path      => ["/usr/bin", "/bin"],
    creates   => "${installdir}/bamboo-${version}",
    cwd       => $installdir,
  } ->

  file { $properties:
    content => "bamboo.home=${home}/data",
    notify  => Service['bamboo'],
  }

  file { [ $home, "${home}/logs"]:
    ensure => directory,
    before => Service['bamboo'],
  }

  file { '/etc/default/bamboo':
    ensure   => present,
    content  => template('bamboo/sysconfig-rhel.erb'),
    notify   => Service['bamboo'],
  }

  case $version {
    /^(4|5\.1)/: {
      file { '/etc/init.d/bamboo':
        ensure => link,
        target => "${dir}/bamboo.sh",
        before => Service['bamboo'],
      }
      service { 'bamboo':
        ensure     => running,
        enable     => false, # service bamboo does not support chkconfig
        hasrestart => true,
        hasstatus  => true,
      }
    }
    default: {
      file { '/etc/init.d/bamboo':
        ensure   => file,
        content  => template('bamboo/init-rhel.erb'),
        mode     => '0655',
        before   => Service['bamboo'],
      }
      service { 'bamboo':
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
      }
    }
  }

}