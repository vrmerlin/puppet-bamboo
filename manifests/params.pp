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
    'Windows': {
      fail('bamboo module is not supported on Windows')
    }
    default: {
      $service_file     = '/etc/init.d/bamboo'
      $service_template = 'bamboo/bamboo.init.erb'
    }
  }

  if $::puppet_confdir =~ /^\/etc\/puppetlabs/ {
    $facter_dir = '/etc/puppetlabs/facter/facts.d'
  } else {
    $facter_dir = '/etc/facter/facts.d'
  }

  $stop_command = 'service bamboo stop && sleep 10'

}
