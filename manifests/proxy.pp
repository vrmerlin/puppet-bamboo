class bamboo::proxy(
  $host,
  $port) {

  # Until Augeas has the properties files fixes, use a custom version
  # Just a basic approach - for more complete management of lenses consider https://github.com/camptocamp/puppet-augeas
  if !defined(File['/tmp/augeas']) {
    file { '/tmp/augeas': ensure => directory }
  }
  file { "/tmp/augeas/bamboo": ensure => directory } ->
  file { "/tmp/augeas/bamboo/properties.aug":
    source => "puppet://modules/bamboo/properties.aug"
  }->

  # Adjust wrapper.conf
  augeas { "set-bamboo-proxy":
    lens      => "Properties.lns",
    incl      => "${bamboo::dir}/conf/wrapper.conf",
    changes   => [
      "set wrapper.java.additional.7 -Dhttp.proxyHost=${host}",
      "set wrapper.java.additional.8 -Dhttp.proxyPort=${port}"
    ],    
    load_path => '/tmp/augeas/bamboo',
    require   => Exec['bamboo'],
    notify    => Service['bamboo'],
  }
}
