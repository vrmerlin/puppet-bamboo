class bamboo::facts (
  $ensure            = $::bamboo::facts_ensure,
  $facter_dir        = $::bamboo::facter_dir,
  $create_facter_dir = $::bamboo::create_facter_dir,
) {

  case $ensure {
    'absent': { $file_ensure = 'absent' }
    default: { $file_ensure = 'file' }
  }

  if $create_facter_dir {
    # Ensure facter's external fact directory exists
    # https://docs.puppet.com/facter/3.5/custom_facts.html#external-facts
    # Not using a file resource to avoid stepping on toes and defined() is
    # parse-order dependent.
    exec { "bamboo_${facter_dir}":
      command => "/bin/mkdir -p '${facter_dir}'",
      creates => $facter_dir,
      before  => File["${facter_dir}/bamboo_facts.txt"],
    }
  }

  file { "${facter_dir}/bamboo_facts.txt":
    ensure  => $file_ensure,
    content => "bamboo_version=${::bamboo::version}",
    mode    => '0444',
  }

  # When using the newer external facts directory, ensure the bamboo facts
  # under /etc/puppetlabs/facter/facts.d/ are absent.
  if ($facter_dir == '/opt/puppetlabs/facter/facts.d') {
    file { '/etc/puppetlabs/facter/facts.d/bamboo_facts.txt':
      ensure => 'absent',
    }
  }

}
