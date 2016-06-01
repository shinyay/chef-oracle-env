#
# Cookbook Name:: oracle-env
# Recipe:: bash_profile
#
# Copyright (c) 2016 Shinya Yanagihara, All Rights Reserved.

#############################
## Set bash_profile

cookbook_file "/home/oracle/.bash_profile" do
  mode 00644
  owner "oracle"
  group "oinstall"
end

