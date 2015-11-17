require 'spec_helper'

describe 'bamboo' do
  context 'supported operating systems' do

    context "bamboo::service class on EL 6" do
      let(:params) {{ }}
      let(:facts) do
        {
          :osfamily                  => 'RedHat',
          :operatingsystemmajrelease => '6',
        }
      end

      it { is_expected.to contain_file('/etc/init.d/bamboo').with(
          'content' => /^export CATALINA_HOME=\/usr\/local\/bamboo\/atlassian-bamboo-5\.9\.7$/
        )
      }
      it { is_expected.to contain_service('bamboo').with(
          'ensure' => 'running',
          'enable' => true,
        )
      }
    end

    context "bamboo::service class on EL 7" do
      let(:facts) do
        {
          :osfamily                  => 'RedHat',
          :operatingsystemmajrelease => '7',
        }
      end

      it { is_expected.to contain_file('/usr/lib/systemd/system/bamboo.service').with(
          'content' => /^PIDFile=\/usr\/local\/bamboo\/atlassian-bamboo-5\.9\.7\/work\/catalina\.pid$/
        )
      }
      it { is_expected.to contain_service('bamboo').with(
          'ensure' => 'running',
          'enable' => true,
        )
      }
    end
  end

end
