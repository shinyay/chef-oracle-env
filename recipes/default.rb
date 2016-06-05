#
# Cookbook Name:: oracle-env
# Recipe:: default
#
# Copyright (c) 2016 Shinya Yanagihara, All Rights Reserved.

#############################
## Create OS groups

groups = { 
  "oinstall" => "54321",
  "dba" => "54322",
  "backupdba" => "54323",
  "oper" => "54324",
  "dgdba" => "54325",
  "kmdba" => "54326"
}

groups.each do |name, gid|
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
  password "ハッシュ化したパスワード"
end

groups.each_key do |name|
  group name do
    members "oracle"
    action :modify
  end
end

#############################
## Create Installation directories

dirs = [
  "/u01",
  "/u01/app",
  "/u01/app/oracle",
  "/u01/app/oracle/product",
  "/u01/app/oracle/config",
  "/u01/app/oracle/config/domains",
  "/u01/app/oracle/config/applications",
  "/u01/app/oraInventory"
]

dirs.each do |dir|
  directory dir do
    mode 00755
    owner "oracle"
    group "oinstall"
  end
end
