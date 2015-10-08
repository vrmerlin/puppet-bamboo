class bamboo::params {

  case $::osfamily {
    'RedHat': {
      if $::operatingsystemmajrelease == '7' {
        $service_file     = '/usr/lib/systemd/system/bamboo.service'
        $service_template = 'bamboo/bamboo.service.erb'
      }
      elsif $::operatingsystemmajrelease == '6' or $::operatingsystem == 'Amazon'{
        $service_file     = '/etc/init.d/bamboo'
        $service_template = 'bamboo/bamboo.init.erb'
      }
      else {
        fail("${::osfamily} ${::operatingsystemmajrelease} not supported.")
      }
    }
    default: {
      $service_file     = '/etc/init.d/bamboo'
      $service_template = 'bamboo/bamboo.init.erb'
    }
  }

}
