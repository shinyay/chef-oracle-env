#
# Cookbook Name:: oracle-env
# Recipe:: fstab
#
# Copyright (c) 2016 Shinya Yanagihara, All Rights Reserved.

#############################
## Configure kernel parameter

cookbook_file "/etc/fstab" do
  mode 00644
  notifies :run, "execute[remount-tmpfs]"
end

execute "remount-tmpfs" do
  command "mount -o remount tmpfs"
  action :nothing
end
