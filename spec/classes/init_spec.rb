require 'spec_helper'

describe 'bamboo' do
  context 'supported operating systems' do

    context "bamboo class without any parameters" do
      let(:params) {{ }}

      it { should contain_class('bamboo') }
      it { should contain_class('bamboo::install') }
      it { should contain_class('bamboo::configure') }
      it { should contain_class('bamboo::service') }

    end
  end

end
