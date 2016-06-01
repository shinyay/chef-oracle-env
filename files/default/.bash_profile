# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

# Oracle Base Directory
export ORACLE_BASE=/u01/app/oracle
umask 022

# Oracle Database
export ORACLE_HOME=/u01/app/oracle/product/12.1.0/dbhome_1
export ORACLE_SID=orcl
export PATH=$ORACLE_HOME/bin:$PATH
#export LANG=ja_JP.UTF-8
export LANG=en_US.UTF-8
#export NLS_LANG=Japanese_Japan.AL32UTF8

# Fusiom Middleware
export ORACLE_HOME=$ORACLE_BASE/product/ofm12.2.1
export MW_HOME=$ORACLE_HOME
export WLS_HOME=$MW_HOME/wlserver
export WL_HOME=$WLS_HOME
export DOMAIN_BASE=$ORACLE_BASE/config/domains
export DOMAIN_HOME=$DOMAIN_BASE/mydomain
