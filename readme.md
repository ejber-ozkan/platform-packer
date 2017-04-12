
<!-- TOC -->

- [Creating images into Azure using Packer](#creating-images-into-azure-using-packer)
    - [pre-requisties:](#pre-requisties)
- [Creating images into AWS...](#creating-images-into-aws)
- [Creating images into VMWare...](#creating-images-into-vmware)
- [Creating images into VirtualBox...](#creating-images-into-virtualbox)
    - [pre-requisties:](#pre-requisties-1)

<!-- /TOC -->

# Creating images into Azure using Packer 
In order to build VMs in Azure Packer needs 6 configuration options to be specified:

subscription_id - UUID identifying your Azure subscription (where billing is handled)

client_id - UUID identifying the Active Directory service principal that will run your Packer builds

client_secret - service principal secret / password

resource_group_name - name of the resource group where your VHD(s) will be stored

storage_account - name of the storage account where your VHD(s) will be stored

## pre-requisties:
- packer ( does most of the heavy lifting).
- azure subscription , with service principal application access credentials.
- azure cli v2

copy az-access.json.dist to az-access.json

( youre json file is .gitignored)

fill in the relevant details : 

```
{
    "client_id": "",
    "client_secret": "",
    "resource_group_name": "",
    "storage_account": "",
    "subscription_id": "",
    "tenant_id": "",
    "date": ""
}
```

(date is optional tag , recommended tags still TBC).

To then create a VHD image for *CentOS 7* run:
```
packer build -var-file=az-access.json azure-centos-7.3-x86_64.json
```
or run the shell script
```
bash run-packer-centos7.sh
```

It is useful to store the output of the packer program as it will contain URI's 
to the VHD templates and disk storage details. These details can then be used in a tool such as terraform to further build out from your new base image.

The `azure-centos-7.3-x86_64.json` file uses a base image from OpenLogic which can then further be stripped or provisioned by executing various provisioners in the `provisioning` section of the json file.
Please see resource/centos/base-programs.sh as an example , but also could be done through ansible , puppet etc

Example:
```
    {
        "type": "ansible-local",
        "playbook_file": "./myspec-packer-ansible-provisioner.yml"
    },
```

Other Notes CLI 2:
set your account to the correct subscription:
```
az account set --subscription xxxx
```
View Images on offer in Azure:
```
az vm image list -o table
```

Create Service Prinicpal:
```
az ad sp create-for-rbac -n ejber-packer-test
```

List applications:
```
az ad app list
```

# Creating images into AWS...
# Creating images into VMWare...
# Creating images into VirtualBox...
## pre-requisties:
- packer
- VirtualBox
- Vagrant 

Running the command:
```
packer build vbox-centos-7.x-x86_64.json
```
will build and provision a CentOS 7 VM for use with Virtual Box and Vagrant.
Running the bash script run-packer-vbox-centos7.sh will do the same but will
also add it to the local vagrant registry so that the newly created 
image can be initialised and used locally.
```
...
vagrant box remove ${VMNAME}
vagrant box add ${VMNAME} VagrantReady/CentOS/virtualbox/centos-7.x.box
vagrant box list
vagrant init ${VMNAME}
...

```

As part of the post provisioning , some examples and useful bash scripts for centos deployments exists in:
```
resources/centos/bash
```
That get run in the provision section of the packer json file, additional files or changes can be added here:
```
      "scripts": [
        "resources/centos/bash/fix-slow-dns.sh",
        "resources/centos/bash/sshd.sh",
        "resources/centos/bash/disablefirewall.sh",
        "resources/centos/bash/base-programs.sh",
        "resources/centos/bash/vagrant.sh",
        "resources/centos/bash/puppet.sh",
        "resources/centos/bash/cleanup.sh",
        "resources/centos/bash/minimize.sh"
      ]
```