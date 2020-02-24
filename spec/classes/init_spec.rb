require 'spec_helper'

describe 'dummy' do
  shared_examples_for "a structured module" do
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to create_class('dummy') }
    it { is_expected.to contain_class('dummy') }
    it { is_expected.to contain_class('dummy::install').that_comes_before('Class[dummy::config]') }
    it { is_expected.to contain_class('dummy::config') }
    it { is_expected.to contain_class('dummy::service').that_subscribes_to('Class[dummy::config]') }

    it { is_expected.to contain_service('dummy') }
    it { is_expected.to contain_package('dummy').with_ensure('installed') }
  end

  context 'supported operating systems' do
    on_supported_os.each do |os, os_facts|
      context "on #{os}" do
        let(:facts) do
          os_facts
        end

        context "dummy class without any parameters" do
          let(:params) {{ }}
          it_behaves_like "a structured module"
          it { is_expected.to contain_class('dummy').with_trusted_nets(['127.0.0.1/32']) }
        end

        context "dummy class with firewall enabled" do
          let(:params) {{
            :firewall => true
          }}

          ###it_behaves_like "a structured module"
          it { is_expected.to contain_class('dummy::config::firewall') }

          it { is_expected.to contain_class('dummy::config::firewall').that_comes_before('Class[dummy::service]') }
          it { is_expected.to create_iptables__listen__tcp_stateful('allow_dummy_tcp_connections').with_dports(9999)
          }
        end

        context "dummy class with selinux enabled" do
          let(:params) {{
            :selinux => true
          }}

          ###it_behaves_like "a structured module"
          it { is_expected.to contain_class('dummy::config::selinux') }
          it { is_expected.to contain_class('dummy::config::selinux').that_comes_before('Class[dummy::service]') }
          it { is_expected.to create_notify('FIXME: selinux') }
        end

        context "dummy class with auditing enabled" do
          let(:params) {{
            :auditing => true
          }}

          ###it_behaves_like "a structured module"
          it { is_expected.to contain_class('dummy::config::auditing') }
          it { is_expected.to contain_class('dummy::config::auditing').that_comes_before('Class[dummy::service]') }
          it { is_expected.to create_notify('FIXME: auditing') }
        end

        context "dummy class with logging enabled" do
          let(:params) {{
            :logging => true
          }}

          ###it_behaves_like "a structured module"
          it { is_expected.to contain_class('dummy::config::logging') }
          it { is_expected.to contain_class('dummy::config::logging').that_comes_before('Class[dummy::service]') }
          it { is_expected.to create_notify('FIXME: logging') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'dummy class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
        :os => {
          :family => 'Solaris',
          :name   => 'Nexenta',
        }
      }}

      it { expect { is_expected.to contain_package('dummy') }.to raise_error(Puppet::Error, /'Nexenta' is not supported/) }
    end
  end
end
