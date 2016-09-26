#
# Cookbook Name:: oracle-env
# Recipe:: cvuqdisk
#
# Copyright (c) 2016 Shinya Yanagihara, All Rights Reserved.
# log  "####{cookbook_name}::#{recipe_name} #{Time.now.inspect}: Starting execution phase"
puts "####{cookbook_name}::#{recipe_name} #{Time.now.inspect}: Starting compile phase"

############################
# Install cvuqdisk

rpm_package 'cvuqdisk' do
  source "#{node[:env][:grid][:cvuqdisk]}"
  action :install
end


# log  "####{cookbook_name}::#{recipe_name} #{Time.now.inspect}: Finished execution phase"
puts "####{cookbook_name}::#{recipe_name} #{Time.now.inspect}: Finished compile phase"
