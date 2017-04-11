#!/bin/bash
sudo yum -y install wget sudo openssh-clients make perl curl nfs-utils bash telnet unzip bind-utils lsof strace tcpdump epel-release
sudo yum -y groupinstall "Development Tools"
sudo yum -y install vim-enhanced.x86_64
sudo yum -y install kernel-devel.x86_64
sudo yum -y install kernel-headers.x86_64
sudo yum -y install nc.x86_64
sudo yum -y install htop
sudo yum -y install sysstat
sudo yum -y install nmap-ncat