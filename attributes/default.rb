default['steamcmd']['user'] = 'steam'
default['steamcmd']['group'] = 'steam'
default['steamcmd']['home'] = "/home/#{node['steamcmd']['user']}"
default['steamcmd']['steamcmd_dir'] = "/opt/steamcmd"
default['steamcmd']['apps_dir'] = "#{node['steamcmd']['home']}/apps"
default['steamcmd']['create_symlinks'] = true
default['steamcmd']['steam']['username'] = nil
default['steamcmd']['steam']['password'] = nil
