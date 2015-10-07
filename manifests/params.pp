class bamboo::params {

  case $::osfamily {
    'RedHat': {
      $service_lockfile = '/var/lock/subsys/bamboo'
      if $::operatingsystemmajrelease == '7' {
        $service_file     = '/etc/init.d/bamboo'
        $service_template = 'bamboo/bamboo.init.erb'
      }
      elsif $::operatingsystemmajrelease == '6' or $::operatingsystem == 'Amazon'{
        $service_file     = '/usr/lib/systemd/system/bamboo.service'
        $service_template = 'bamboo/bamboo.service.erb'
      }
      else {
        fail("${::osfamily} ${::operatingsystemmajrelease} not supported.")
      }
    }
    default: {
      $service_lockfile = '/var/lock/bamboo'
      $service_file     = '/etc/init.d/bamboo'
      $service_template = 'bamboo/bamboo.init.erb'
    }
  }

}
