#
# Cookbook Name:: oracle-env
# Recipe:: default
#
# Copyright (c) 2016 Shinya Yanagihara, All Rights Reserved.

[:platform, :platform_version, :ipaddress, :fqdn, :hostname].each do |key|
  puts "node['#{key}'] = #{node[key]}"
end

#############################
## Create OS groups

oracle_groups = { 
  "oinstall" => "54321",
  "dba" => "54322",
  "backupdba" => "54323",
  "oper" => "54324",
  "dgdba" => "54325",
  "kmdba" => "54326",
  "asmadmin" => "54327",
  "asmdba" => "54328",
  "asmoper" => "54329"
}

grid_groups = {
  "asmadmin" => "54327",
  "asmdba" => "54328",
  "asmoper" => "54329"
}

oracle_groups.each do |name, gid|
  group name do
    gid gid
  end
end

grid_groups.each do |name, gid|
  group name do
    gid gid
  end
end

#############################
## Create OS user

user "oracle" do
  uid 1200
  gid "oinstall"
  supports :manage_home => true
  home "/home/oracle"
  password "$1$YnHMPdkH$/KqjmWACS3iTb/.sfxMg30"
end

oracle_groups.each_key do |name|
  group name do
    members "oracle"
    action :modify
  end
end
group "asmadmin" do
  members "oracle"
  action :modify
  append true
end 

user "grid" do
  uid 1100
  gid "oinstall"
  supports :manage_home => true
  home "/home/grid"
  password "$1$YnHMPdkH$/KqjmWACS3iTb/.sfxMg30"
end

grid_groups.each_key do |name|
  group name do
    members "grid"
    action :modify
  end
end

#############################
## Create Installation directories

oracle_dirs = [
  "/u01",
  "/u01/app",
  "/u01/app/oracle",
  "/u01/app/oracle/product",
  "/u01/app/oracle/product/12.1.0",
  "/u01/app/oracle/product/12.1.0/dbhome_1",
  "/u01/app/oracle/config",
  "/u01/app/oracle/config/domains",
  "/u01/app/oracle/config/applications",
  "/u01/app/oraInventory"
]

grid_dirs = [
  "/u01/app/oracle/product/12.1.0/grid",
  "/u01/app/grid"
]

oracle_dirs.each do |dir|
  directory dir do
    mode 00775
    owner "oracle"
    group "oinstall"
  end
end

grid_dirs.each do |dir|
  directory dir do
    mode 00775
    owner "grid"
    group "oinstall"
  end
end

