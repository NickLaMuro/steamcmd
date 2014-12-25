# Encoding: utf-8
#
# Cookbook Name:: steamcmd
# Recipe:: counterstrike_source
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

include_recipe 'steamcmd::default'

cfg_file = "#{node['steamcmd']['apps_dir']}/#{params[:app_id]}/cstrike/cfg/config_default.cfg"

steamcmd_app app_name do
  app_id 232330
  app_name app_name
  use_upstart true
  game_exec 'srcds_run'
  exec_opts %Q{-game cstrike +ip 0.0.0.0 +servercfgfile #{cfg_file} -flushlog -debug -allowdebug -dev +sv_lan 1 +hostname "my_cstrike_server" +game_type 0 +game_mode 0 +map de_dust2}
end
