include_recipe "spawn-fcgi"
include_recipe "magento"
include_recipe "nginx"

if node.has_key?("ec2")
  server_fqdn = node.ec2.public_hostname
else
  server_fqdn = node.fqdn
end

case node['platform_family']
when 'debian', 'ubuntu'
    bash "Tweak FPM php.ini file" do
      cwd "/etc/php5/fpm"
      code <<-EOH
      sed -i 's/memory_limit\s*=\s*.*/memory_limit = 128M/' php.ini
      sed -i 's/;\s*realpath_cache_size\s*=\s*.*/realpath_cache_size = 32K/' php.ini
      sed -i 's/;\s*realpath_cache_ttl\s*=\s*.*/realpath_cache_ttl = 7200/' php.ini
      EOH
      notifies :restart, resources(:service => "php-fpm")
    end
end
directory "#{node[:nginx][:dir]}/ssl" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

bash "Create SSL Certificates" do
  cwd "#{node[:nginx][:dir]}/ssl"
  code <<-EOH
  umask 022
  openssl genrsa 2048 > magento.key
  openssl req -batch -new -x509 -days 365 -key magento.key -out magento.crt
  cat magento.crt magento.key > magento.pem
  EOH
  only_if { File.zero?("#{node[:nginx][:dir]}/ssl/magento.pem") }
  action :nothing
end

cookbook_file "#{node[:nginx][:dir]}/ssl/magento.pem" do
  source "cert.pem"
  mode 0644
  owner "root"
  group "root"
  notifies :run, resources(:bash => "Create SSL Certificates"), :immediately
end

%w{backend}.each do |file|
  cookbook_file "#{node[:nginx][:dir]}/conf.d/#{file}.conf" do
    source "nginx/#{file}.conf"
    mode 0644
    owner "root"
    group "root"
  end
end

#@TODO: Don't want to automatically create site configs at this stage
%w{default ssl}.each do |site|
  template "#{node[:nginx][:dir]}/sites-available/#{site}" do
    source "nginx-site.erb"
    owner "root"
    group "root"
    mode 0644
    variables(
      :path => "#{node[:magento][:dir]}",
      :ssl => (site == "ssl")?true:false
    )
  end
  nginx_site "#{site}" do
    notifies :reload, resources(:service => "nginx")
  end
end

#@TODO: Don't want this to automatically create a dir, should create a configurable attribute to test whether or not to do this.
#execute "ensure correct ownership" do
#  command "chown -R #{node[:magento][:user]}:#{node[:nginx][:user]} #{node[:magento][:dir]}"
#  action :run
#end
