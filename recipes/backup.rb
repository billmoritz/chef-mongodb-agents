#
# Cookbook Name:: mongodb-agents
# Recipe:: backup
#
# Copyright 2015, Bill Moritz
#
# All rights reserved - Do Not Redistribute
#

package_name = "mongodb-mms-backup-agent"
package_file = "#{package_name}_#{node['mongodb-agents']['backup']['version']}_#{node['kernel']['machine'] == 'x86_64' ? 'amd64' : 'i386'}.deb"
download_url = "#{node['mongodb-agents']['agent_url']}/backup/#{package_file}"

remote_file "#{Chef::Config[:file_cache_path]}/#{package_file}" do
  action :create_if_missing
  backup 5
  owner "root"
  group "root"
  mode "0644"
  source download_url
end

dpkg_package package_name do
  action :install
  source "#{Chef::Config[:file_cache_path]}/#{package_file}"
end

template "/etc/mongodb-mms/backup-agent.config" do
  source "backup-agent.config.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, "service[mongodb-mms-backup-agent]"
  variables( :api_key => node['mongodb-agents']['api_key'],
             :mothership => node['mongodb-agents']['mothership'],
             :use_https => node['mongodb-agents']['use_https'].to_s,
             :group_id => node['mongodb-agents']['group_id'] )
end

service "mongodb-mms-backup-agent" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
