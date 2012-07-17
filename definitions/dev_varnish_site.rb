define :dev_varnish_site, :port => nil do
  Chef::Log.info("Create varnish for: #{params[:name]}")
  template "varnish-site" do
    source "varnish-cache.vcl.erb"
    path "/var/www/#{params[:name]}/config/varnish.vcl"
    mode 0644
    action :create_if_missing
    notifies :run, "execute[#{params[:name]}-varnish]", :delayed
  end
  template "varnish-upstart" do
    source "varnish-upstart.erb"
    path "/etc/init/#{params[:name]}}-varnish.conf"
    mode 0644
    variables(
        :port => params[:port],
        :backendPort => (params[:port] + 100),
        :name => params[:name],
        :vclPath => "/var/www/#{params[:name]}/config/varnish.vcl"
    )
    notifies :run, "execute[#{params[:name]}-varnish]", :delayed
  end
  execute "#{params[:name]}-varnish" do
    command "service #{params[:name]}-varnish start || service #{params[:name]}-varnish restart"
    action :nothing
  end
end