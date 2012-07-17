
define :dev_mysql_db_permissions do

  name = params[:name][0,16]
  mysqlCommand = "\"#{node['mysql']['mysql_bin']}\" -u root #{node['mysql']['server_root_password'].empty? ? '' : '-p' }\"#{node['mysql']['server_root_password']}\""
  grantStatement = <<-GRANTCMD
  CREATE USER \\`#{name}\\`@'localhost' IDENTIFIED BY '#{name}';
  GRANT USAGE ON \*.\* TO \\`#{name}\\`@'localhost' IDENTIFIED BY '#{name}' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;
  CREATE DATABASE IF NOT EXISTS \\`#{name}\\` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
  GRANT ALL PRIVILEGES ON \\`#{name}\\`.\* TO '#{name}'@'localhost';
  FLUSH PRIVILEGES;
  GRANTCMD

  execute "mysql-permissions-#{name}" do
    command "echo \"DROP USER \\`#{name}\\`@'localhost'\" | #{mysqlCommand} || exit 0 ; echo \"#{grantStatement}\" | #{mysqlCommand}"
  end
end