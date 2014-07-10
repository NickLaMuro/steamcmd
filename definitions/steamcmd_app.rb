define :steamcmd_app, :app_id => nil, :app_name => nil, :app_game => nil, :cfg_file => nil do

  include_recipe 'steamcmd::default'

  if node['steamcmd']['create_symlinks']
    link "#{node['steamcmd']['home']}/#{params[:app_name]}" do
      to "#{node['steamcmd']['apps_dir']}/#{params[:app_id]}"
      action :create
    end
  end

  dir = "#{node['steamcmd']['apps_dir']}/#{params[:app_id]}"
  params[:cfg_file] = "#{dir}/#{params[:cfg_file]}"

  execute "install #{params[:app_name]}" do
    only_if {
      !::File.directory?(dir) ||
      (::File.directory?(dir) && ::Dir.entries(dir).empty?)
    }
    user node['steamcmd']['user']
    group node['steamcmd']['group']
    cwd node['steamcmd']['apps_dir']
    command "#{node['steamcmd']['steamcmd_dir']}/steamcmd.sh +login anonymous +force_install_dir #{dir} +app_update #{params[:app_id]} validate +quit"
    action :run
    retries 3
    retry_delay 5
  end

  template "/etc/init/#{params[:app_name]}.conf" do
    mode '0644'
    source 'upstart.erb'
    variables({ :params => params })
    notifies :restart, "service[#{params[:app_name]}]"
  end

  link '/etc/init.d/counterstrike_source' do
    to '/lib/init/upstart-job'
    action :create
  end

  service params[:app_name] do
    # Upstart does not re-read configuration on restart
    # TODO: Make this stop+start instead
    provider Chef::Provider::Service::Upstart
    supports :restart => true, :reload => false, :status => false
    action [ :enable, :start ]
  end

end
