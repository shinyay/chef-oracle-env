#
# Cookbook Name:: oracle-env
# Recipe:: default
#
# Copyright (c) 2016 Shinya Yanagihara, All Rights Reserved.

[:platform, :platform_version, :ipaddress, :fqdn, :hostname].each do |key|
  puts "node['#{key}'] = #{node[key]}"
end

#############################
## Create OS user

oracle_groups = {
  "oinstall" => "54321",
  "dba" => "54322",
  "backupdba" => "54323",
  "oper" => "54324",
  "dgdba" => "54325",
  "kmdba" => "54326",
}

asm_groups = {
  "asmadmin" => "54327",
  "asmdba" => "54328",
  "asmoper" => "54329"
}

user "oracle" do
  uid 1200
  manage_home true
  home "/home/oracle"
  password "$1$YnHMPdkH$/KqjmWACS3iTb/.sfxMg30"
end

oracle_groups.each do |name, gid|
  group name do
    members "oracle"
    gid gid
  end
end

user "grid" do
  uid 1100
  manage_home true
  home "/home/grid"
  password "$1$YnHMPdkH$/KqjmWACS3iTb/.sfxMg30"
end

asm_groups.each do |name, gid|
  group name do
    members "grid"
    gid gid
  end
end

group "asmadmin" do
  members "oracle"
  action :modify
  append true
end
group "asmdba" do
  members "oracle"
  action :modify
  append true
end
group "dba" do
  members "grid"
  action :modify
  append true
end

#############################
## Create Installation directories

oracle_dirs = [
  "/u01",
  "/u01/app",
  "/u01/app/oracle",
  "/u01/app/oracle/product",
  "/u01/app/oracle/product/12.1.0.2",
  "/u01/app/oracle/product/12.1.0.2/dbhome_1",
  "/u01/app/oracle/config",
  "/u01/app/oracle/config/domains",
  "/u01/app/oracle/config/applications",
  "/u01/app/oraInventory"
]

grid_dirs = [
  "/u01/app/oracle/product/12.1.0.2/grid",
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

