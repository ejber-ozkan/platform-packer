#!/bin/bash

packer build -var-file=az-access.json azure-centos-7.3-x86_64.json
