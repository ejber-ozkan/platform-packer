#!/bin/bash -eux
# WARNING: REQUIRES /bin/bash

# Install Puppet

CENTOS_VERSION=`cat /etc/redhat-release | grep -oE '[0-9]+\.[0-9]+'`

if [ "$CENTOS_VERSION" = "7.0" ] || [ "$CENTOS_VERSION" = "7.1" ] || [ "$CENTOS_VERSION" = "7.2" ] || [ "$CENTOS_VERSION" = "7.3" ]
then
	rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
else
	rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
fi

yum --disablerepo=epel -y install puppet
