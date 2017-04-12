#!/bin/bash
sudo useradd vagrant
sudo echo "vagrant" | passwd --stdin "vagrant"
sudo echo "vagrant" | passwd --stdin "root"
wget --no-check-certificate https://releases.hashicorp.com/vagrant/1.9.3/vagrant_1.9.3_x86_64.rpm
sudo rpm -i vagrant_1.9.3_x86_64.rpm
sudo mkdir /vagrant
sudo mkdir /home/vagrant
sudo mkdir /home/vagrant/.ssh
sudo wget --no-check-certificate -O authorized_keys 'https://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub'
sudo mv authorized_keys /home/vagrant/.ssh
chown -R vagrant /home/vagrant/.ssh
chmod -R go-rwsx /home/vagrant/.ssh
chmod -R 0600 /home/vagrant/.ssh/authorized_keys
sudo wget --no-check-certificate -O/etc/pki/tls/certs/ca-bundle.crt https://curl.haxx.se/ca/cacert.pem
sudo echo "%vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/vagrant
sudo sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
sudo echo "%ec2-user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/vagrant
