require 'spec_helper'

describe 'bamboo' do
  context 'supported operating systems' do

    context "bamboo::install class with defaults" do
      let(:params) {{ }}

      it { is_expected.to contain_user('bamboo').with(
          'shell'      => '/bin/bash',
          'home'       => '/var/local/bamboo',
          'managehome' => true,
          )
      }

      it { is_expected.to contain_group('bamboo') }

      it { is_expected.to contain_file('/usr/local/bamboo').with(
          'owner' => 'bamboo',
          'group' => 'bamboo',
        )
      }

      it { is_expected.to contain_file('/usr/local/bamboo/atlassian-bamboo-5.9.7').with(
          'owner' => 'bamboo',
          'group' => 'bamboo',
        )
      }

      it { is_expected.to contain_staging__file('atlassian-bamboo-5.9.7.tar.gz').with(
          'source'  => 'https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-5.9.7.tar.gz',
          'timeout' => '1800',
        )
      }

      it { is_expected.to contain_staging__extract('atlassian-bamboo-5.9.7.tar.gz').with(
          'target'  => '/usr/local/bamboo/atlassian-bamboo-5.9.7',
          'creates' => '/usr/local/bamboo/atlassian-bamboo-5.9.7/conf',
          'user'    => 'bamboo',
          'group'   => 'bamboo',
        )
      }

      it { is_expected.to contain_file('/var/local/bamboo/logs').with(
          'owner' => 'bamboo',
          'group' => 'bamboo',
        )
      }

      it { is_expected.to contain_exec('chown_/usr/local/bamboo/atlassian-bamboo-5.9.7').with(
          'command' => 'chown -R bamboo:bamboo /usr/local/bamboo/atlassian-bamboo-5.9.7',
        )
      }
    end
  end

end
