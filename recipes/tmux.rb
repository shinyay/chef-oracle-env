#
# Cookbook Name:: oracle-env
# Recipe:: tmux
#
# Copyright (c) 2016 Shinya Yanagihara, All Rights Reserved.
# log  "####{cookbook_name}::#{recipe_name} #{Time.now.inspect}: Starting execution phase"
puts "####{cookbook_name}::#{recipe_name} #{Time.now.inspect}: Starting compile phase"

############################
# Install ncurses

package 'Install ncurses' do
  package_name 'ncurses-devel'
  action       :install
end

############################
## Create Directory
dirs = [
  "/root/tmp",
  "/root/tmp/libevent2",
  "/root/tmp/tmux"
]

dirs.each do |dir|
  directory dir do
    mode 00775
  end
end
############################
## Install libevent2

src_libevent_name = "libevent-2.0.22-stable"
src_libevent_path = "/root/tmp/libevent2"

remote_file 'Download libevent2' do
  source "https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz"
  path   "#{src_libevent_path}/#{src_libevent_name}.tar.gz"
  not_if { ::File.exists?(src_libevent_path+'/'+src_libevent_name+'.tar.gz') }
end

bash 'Extract libevent2' do
  cwd ::File.dirname(src_libevent_path)
  code <<-EOH
    tar -xvzf #{src_libevent_path}/#{src_libevent_name}.tar.gz
    cd #{src_libevent_name}
    ./configure --prefix=/usr/local
    make
    make install
    EOH
  not_if { ::File.exists?('/usr/local/lib/libevent.so') }
end

############################
## Install tmux

src_tmux_name = "tmux-2.3"
src_tmux_path = "/root/tmp/tmux"

remote_file 'Download tmux' do
  source "https://github.com/tmux/tmux/releases/download/2.3/tmux-2.3.tar.gz"
  path   "#{src_tmux_path}/#{src_tmux_name}.tar.gz"
  not_if { ::File.exists?(src_tmux_path+'/'+src_tmux_name+'.tar.gz') }
end

bash 'Extract tmux' do
  cwd ::File.dirname(src_tmux_path)
  code <<-EOH
    tar -xvzf #{src_tmux_path}/#{src_tmux_name}.tar.gz
    cd #{src_tmux_name}
    LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
    make
    make install
    EOH
  not_if { ::File.exists?('/usr/local/bin/tmux') }
end



# log  "####{cookbook_name}::#{recipe_name} #{Time.now.inspect}: Finished execution phase"
puts "####{cookbook_name}::#{recipe_name} #{Time.now.inspect}: Finished compile phase"
