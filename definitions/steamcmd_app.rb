define :steamcmd_app, :app_id => nil, :app_name => nil, :use_upstart => false,
                      :upstart_template => nil, :upstart_template_cookbook => nil do

  include_recipe 'steamcmd::default'

  if node['steamcmd']['create_symlinks']
    link "#{node['steamcmd']['home']}/#{params[:app_name]}" do
      to "#{node['steamcmd']['apps_dir']}/#{params[:app_id]}"
      action :create
    end
  end

  dir = "#{node['steamcmd']['apps_dir']}/#{params[:app_id]}"

  if params[:username] and params[:password]
    login = "#{params[:username]} #{params[:password]}"
  else
    login = 'anonymous'
  end

  execute "install #{params[:app_name]}" do
    only_if {
      !::File.directory?(dir) ||
      (::File.directory?(dir) && ::Dir.entries(dir).empty?)
    }
    user node['steamcmd']['user']
    group node['steamcmd']['group']
    cwd node['steamcmd']['apps_dir']
    command "#{node['steamcmd']['steamcmd_dir']}/steamcmd.sh +login #{login} +force_install_dir #{dir} +app_update #{params[:app_id]} validate +quit"
    action :run
    retries params[:retries] || 3
    retry_delay 5
  end

  if params[:use_upstart]
    upstart_template = params[:upstart_template] || 'upstart.erb'
    upstart_template_cookbook = params[:upstart_template_cookbook] || 'steamcmd'

    template "/etc/init/#{params[:app_name]}.conf" do
      mode '0644'
      source upstart_template
      cookbook upstart_template_cookbook
      variables({ :params => params })
      notifies :restart, "service[#{params[:app_name]}]"
    end

    service params[:app_name] do
      # Upstart does not re-read configuration on restart
      # TODO: Make this stop+start instead
      provider Chef::Provider::Service::Upstart
      supports :restart => true, :reload => false, :status => false
      action [ :enable, :start ]
    end
  end

end
