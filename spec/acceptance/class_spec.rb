require 'spec_helper_acceptance'

describe 'bamboo class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do
      pp = <<-EOS

      if $::operatingsystemmajrelease == '16.04' {
        $java_home = "/usr/lib/jvm/java-8-openjdk-${::architecture}"
      } else {
        $java_home = $::osfamily ? {
          'RedHat' => '/etc/alternatives/java_sdk',
          'Debian' => "/usr/lib/jvm/java-7-openjdk-${::architecture}",
          default  => undef
        }
      }

      if !empty('#{BAMBOO_DOWNLOAD_URL}') {
        $download_url = '#{BAMBOO_DOWNLOAD_URL}'
        notice("BAMBOO_DOWNLOAD_URL is set. Using ${download_url}")
      } else {
        $download_url = undef
      }

      if !empty('#{BAMBOO_VERSION}') {
        $version = '#{BAMBOO_VERSION}'
        notice("BAMBOO_VERSION is set. Using ${version}")
      } else {
        $version = undef
      }

      class{'java':}->
      class { 'bamboo':
				java_home    => $java_home,
        download_url => $download_url,
        version      => $version,
			}
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
      shell('sleep 10')
    end

    describe service('bamboo') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe port(8085) do
      it { is_expected.to be_listening }
    end
  end
end
