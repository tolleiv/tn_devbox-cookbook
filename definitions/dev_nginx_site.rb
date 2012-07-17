define :dev_nginx_site, :varnishPort => nil do
  Chef::Log.info("Create nginx host: #{params[:name]}")
  template "nginx-site" do
    source "nginx-site.erb"
    path "/etc/nginx/sites-available/#{params[:name]}"
    mode 0644
    variables(:name => params[:name], :varnishPort => params[:varnishPort])
  end
  nginx_site "#{params[:name]}"
end