#
# Cookbook Name:: oracle-env
# Recipe:: kernel-parameter
#
# Copyright (c) 2016 Shinya Yanagihara, All Rights Reserved.

#############################
## Configure kernel parameter

cookbook_file "/etc/sysctl.conf" do
  mode 00644
  notifies :run, "execute[sysctl-p]", :immediately
end

execute "sysctl-p" do
  command "/sbin/sysctl -p"
  action :nothing
end
