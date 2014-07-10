# Encoding: utf-8
#
# Cookbook Name:: steamcmd
# Recipe:: default
#
# Copyright 2014, Marcin Sawicki
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package 'lib32gcc1'

user node['steamcmd']['user'] do
  action :create
  supports :manage_home => true
  home node['steamcmd']['home']
end

directory node['steamcmd']['steamcmd_dir'] do
  owner node['steamcmd']['user']
  group node['steamcmd']['group']
  mode '0755'
  action :create
end

directory node['steamcmd']['apps_dir'] do
  owner node['steamcmd']['user']
  group node['steamcmd']['group']
  mode '0755'
  action :create
end

unless ::File.exists?("#{node['steamcmd']['steamcmd_dir']}/steamcmd.sh")

  remote_file "/tmp/steamcmd_linux.tar.gz" do
    source "http://media.steampowered.com/installer/steamcmd_linux.tar.gz"
    owner node['steamcmd']['user']
    group node['steamcmd']['group']
    mode '0755'
    action :create
  end

  execute 'steamcmd_linux.tar.gz' do
    user node['steamcmd']['user']
    group node['steamcmd']['group']
    cwd node['steamcmd']['steamcmd_dir']
    command "tar -xvzpf /tmp/steamcmd_linux.tar.gz && rm /tmp/steamcmd_linux.tar.gz"
    timeout 1800
  end

end
