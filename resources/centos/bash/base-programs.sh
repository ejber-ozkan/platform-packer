#!/bin/bash
# All extras addable or removeable as/if and when required....
sudo yum -y install epel-release 
sudo yum --disablerepo="epel" reinstall ca-certificates
sudo yum --disablerepo="epel" -y install wget sudo openssh-clients make perl curl nfs-utils bash telnet unzip bind-utils lsof strace tcpdump
sudo yum --disablerepo="epel" -y groupinstall "Development Tools"
sudo yum --disablerepo="epel" -y  install vim-enhanced.x86_64 kernel-devel.x86_64 kernel-headers.x86_64 sysstat nmap-ncat
sudo yum -y install htop

export DATE=`date`
sudo echo "M&S Packed CentOS7.x base image built on ${DATE}" >> /etc/motd
