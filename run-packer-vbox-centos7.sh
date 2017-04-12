#!/bin/bash

export VMNAME='centos-7-mybox'

echo "building '${VMNAME}' using packer...."
packer build vbox-centos-7.x-x86_64.json

vagrant box remove ${VMNAME}
vagrant box add ${VMNAME} VagrantReady/CentOS/virtualbox/centos-7.x.box
vagrant box list
#vagrant init ${VMNAME}
echo "To initialise 'vagrant init ${VMNAME}' ,you can run it with 'vagrant up /destroy'"
