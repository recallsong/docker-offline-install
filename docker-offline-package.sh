#!/usr/bin/env bash
set -ex;

CUR_DIR=`pwd`
TMP_DIR=`mktemp -d`
cd "${TMP_DIR}"
mkdir -p yum/local

repotrack -a x86_64 -p yum/local createrepo
repotrack -a x86_64 -p yum/local device-mapper-persistent-data
repotrack -a x86_64 -p yum/local lvm2 
repotrack -a x86_64 -p yum/local libgudev1
repotrack -a x86_64 -p yum/local systemd-sysv

yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

repotrack -a x86_64 -p yum/local docker-ce

tar -zcvf "${CUR_DIR}/docker-ce-yum.tgz" yum/
rm -rf "${TMP_DIR}"