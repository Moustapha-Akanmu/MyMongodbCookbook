#
# Cookbook:: mongo
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

apt_update 'update_sources' do
  action :update
end

#add mongodb
apt_repository 'mongodb-org' do
  uri 'http://repo.mongodb/apt/ubuntu'
  distribution 'trusty/mongodb-org/5.3'
  components ['multiverse']
  keyserver 'hkp://keyserver.ubuntu.com:80'
  key 'EA312927'
  action :add
end

#creating template
template '/etc/mongod.conf' do
  source 'mongod.conf.erb'
  mode '0755'
  owner 'root'
  group 'root'
end

template '/etc/systemd/system/mongod.service' do
  source 'mongod.service.erb'
  mode '0600'
  owner 'root'
  group 'root'
end


 package 'mongodb-org' do
   options '--allow-unauthenticated'
   action :install
 end

  service 'mongod' do
    action [:enable, :start]
  end
