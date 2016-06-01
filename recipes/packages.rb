#
# Cookbook Name:: oracle-env
# Recipe:: packages
#
# Copyright (c) 2016 Shinya Yanagihara, All Rights Reserved.

#############################
## Install Packages

pkgs = [
  "oracle-rdbms-server-12cR1-preinstall",
  "binutils",
  "compat-libcap1",
  "compat-libstdc++-33",
  "gcc",
  "gcc-c++",
  "glibc",
  "glibc-devel",
  "ksh",
  "libgcc",
  "libstdc++",
  "libstdc++-devel",
  "libaio",
  "libaio-devel",
  "libXext",
  "libXtst",
  "libX11",
  "libXau",
  "libxcb",
  "libXi",
  "make",
  "sysstat"
]

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end
