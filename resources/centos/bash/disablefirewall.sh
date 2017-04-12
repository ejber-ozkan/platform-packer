#!/bin/bash

CENTOS_VERSION=`cat /etc/redhat-release | grep -oE '[0-9]+\.[0-9]+'`

sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

if [ "$CENTOS_VERSION" = "7.0" ] || [ "$CENTOS_VERSION" = "7.1" ] || [ "$CENTOS_VERSION" = "7.2" ] ||  [ "$CENTOS_VERSION" = "7.3" ]
then
	sudo setenforce 0
	systemctl mask firewalld
	systemctl stop firewalld
else
	sudo echo 0 >/selinux/enforce
	sudo su
	/etc/init.d/iptables stop
	chkconfig iptables off
fi
