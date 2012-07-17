define :dev_apache_site do
  Chef::Log.info("Create apache host: #{params[:name]}")
  template "apache2-site" do
    source "apache2-site.erb"
    path "/etc/apache2/sites-available/#{params[:name]}"
    mode 0644
    variables(:name => params[:name])
  end
  apache_site "#{params[:name]}"
end