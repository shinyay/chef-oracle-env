#
# Cookbook Name:: oracle-env
# Recipe:: ulimit
#
# Copyright (c) 2016 Shinya Yanagihara, All Rights Reserved.

#############################
## Add ulimit

cookbook_file "/etc/security/limits.d/91-oracledb12c.conf" do
  mode 00644
end

