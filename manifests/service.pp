class bamboo::service (
  $version          = $bamboo::version,
  $appdir           = $bamboo::real_appdir,
  $user             = $bamboo::user,
  $shell            = $bamboo::shell,
  $java_home        = $bamboo::java_home,
  $manage_service   = $bamboo::manage_service,
  $service_ensure   = $bamboo::service_ensure,
  $service_enable   = $bamboo::service_enable,
  $service_file     = $bamboo::service_file,
  $service_template = $bamboo::service_template,
  $shutdown_wait    = $bamboo::shutdown_wait,
) {

  file { $service_file:
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template($service_template),
  }

  if $manage_service {
    service { 'bamboo':
      ensure    => $service_ensure,
      enable    => $service_enable,
      subscribe => File[$service_file],
    }
  }

}
