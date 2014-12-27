# Encoding: utf-8

require 'spec_helper'

describe 'counterstrike_source' do

  describe file('/home/steam/counterstrike_source') do
    it { should be_symlink }
  end

  describe file('/home/steam/apps/232330') do
    it { should be_directory }
  end

  describe file('/etc/init/counterstrike_source.conf') do
    it { should be_file }
    its(:content) { should match 'description "counterstrike_source"' }
    its(:content) { should match 'setuid steam' }
    its(:content) { should match 'setgid steam' }
  end

  describe service('counterstrike_source') do
    it { should be_enabled }
    it { should be_running.under('upstart') }
  end

end
