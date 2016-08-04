#
# Cookbook Name:: oracle-env
# Recipe:: bash_profile
#
# Copyright (c) 2016 Shinya Yanagihara, All Rights Reserved.

#############################
# Create Directory for Response files
directory node[:env][:bash][:response_file_dir] do
  owner node[:env][:bash][:owner]
  group node[:env][:bash][:group]
  mode '0775'
end

#############################
# Create bash_profile for oracle user
template node[:env][:bash][:bash_profile_install] do
  source 'bash_profile.erb'
  mode 00644
  owner node[:env][:bash][:owner]
  group node[:env][:bash][:group]
  mode '0644'
end

