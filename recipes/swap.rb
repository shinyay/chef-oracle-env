#
# Cookbook Name:: oracle-env
# Recipe:: swap
#
# Copyright (c) 2016 Shinya Yanagihara, All Rights Reserved.
# log  "####{cookbook_name}::#{recipe_name} #{Time.now.inspect}: Starting execution phase"
puts "####{cookbook_name}::#{recipe_name} #{Time.now.inspect}: Starting compile phase"

############################
# Create Swap file
execute "make swapfile" do
  user 'root'
  group 'root'
  command "dd if=/dev/zero of=#{node[:env][:swap][:swapfile]} bs=#{node[:env][:swap][:blocksize]} count=#{node[:env][:swap][:count]} && chmod 600 #{node[:env][:swap][:swapfile]} && mkswap #{node[:env][:swap][:swapfile]}"
end

mount '/dev/null' do
  action :enable
  device "#{node[:env][:swap][:swapfile]}"
  fstype :swap
end

execute "activate swap" do
  user 'root'
  group 'root'
  command "swapon -ae"
end

# log  "####{cookbook_name}::#{recipe_name} #{Time.now.inspect}: Finished execution phase"
puts "####{cookbook_name}::#{recipe_name} #{Time.now.inspect}: Finished compile phase"
