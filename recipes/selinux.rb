#
# Cookbook Name:: oracle-env
# Recipe:: selinux
#
# Copyright (c) 2016 Shinya Yanagihara, All Rights Reserved.
# log  "####{cookbook_name}::#{recipe_name} #{Time.now.inspect}: Starting execution phase"
puts "####{cookbook_name}::#{recipe_name} #{Time.now.inspect}: Starting compile phase"

############################
# Configure selinux
bash 'selinux' do
  user 'root'
  code <<-EOC
cp -p /etc/sysconfig/selinux /etc/sysconfig/selinux.old
cat /etc/sysconfig/selinux.old | sed 's/^SELINUX=.*$/SELINUX=disabled/' > /etc/sysconfig/selinux
  EOC
  not_if "grep -q 'SELINUX=disabled' /etc/sysconfig/selinux"
end

# log  "####{cookbook_name}::#{recipe_name} #{Time.now.inspect}: Finished execution phase"
puts "####{cookbook_name}::#{recipe_name} #{Time.now.inspect}: Finished compile phase"
