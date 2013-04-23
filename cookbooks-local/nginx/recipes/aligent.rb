bash "remove default.conf" do
  user "root"
  code <<-EOH
    rm -rf /etc/nginx/conf.d/default.conf
  EOH
end

service 'nginx' do
  action :restart
end