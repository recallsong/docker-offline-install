#!/usr/bin/env bash
set -ex;

PKG_FILE="$1"
CUR_DIR=`pwd`

tar -zxvf ${PKG_FILE} -C "${CUR_DIR}/"

cd yum/local
rpm -Uvh deltarpm-*
rpm -Uvh python-deltarpm-*
rpm -ivh createrepo-*

echo "[Local]" > /etc/yum.repos.d/docker-ce-local.repo
echo "name=Local Yum" >> /etc/yum.repos.d/docker-ce-local.repo
echo "baseurl=file://${CUR_DIR}/yum/" >> /etc/yum.repos.d/docker-ce-local.repo
echo "gpgcheck=0" >> /etc/yum.repos.d/docker-ce-local.repo
echo "gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7" >> /etc/yum.repos.d/docker-ce-local.repo
echo "enabled=1" >> /etc/yum.repos.d/docker-ce-local.repo

createrepo "${CUR_DIR}/yum"
yum makecache
yum install docker-ce