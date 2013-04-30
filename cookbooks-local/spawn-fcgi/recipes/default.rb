#
# Cookbook Name:: spawn-fcgi
# Recipe:: default
#
# Copyright 2013, Aligent Consulting
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'yum::epel'
include_recipe 'nginx'

packages = %w{ spawn-fcgi }

packages.each do |pkg|
  package pkg do
    action :install
  end
end

template "/etc/sysconfig/spawn-fcgi" do
  source "spawn-fcgi.erb"
  owner "root"
  group "root"
  mode "0600"
end

service "spawn-fcgi" do
  supports :restart => true, :status => true, :reload => true
  action [:enable, :start]
end