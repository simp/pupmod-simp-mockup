require 'spec_helper_acceptance'

test_name 'dummy class'

describe 'dummy class' do
  let(:manifest) do
    <<-EOS
      class { 'dummy': }
    EOS
  end

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'works with no errors' do
      apply_manifest(manifest, catch_failures: true)
    end

    it 'is idempotent' do
      apply_manifest(manifest, catch_changes: true)
    end

    describe package('dummy') do
      it { is_expected.to be_installed }
    end

    describe service('dummy') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end
