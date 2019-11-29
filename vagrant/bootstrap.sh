#!/bin/bash

set -e

TIMEZONE=Europe/Berlin

if [ "$(timedatectl get-timezone)"  != "$TIMEZONE" ]; then
  echo "Setting timezone to $TIMEZONE"
  timedatectl set-timezone "$TIMEZONE"
fi

if ! rpm -q puppet6-release &>/dev/null && ! rpm -q puppet-release &>/dev/null; then
  echo "Installing puppet-release ROM"
  yum install -y https://yum.puppetlabs.com/puppet6-release-el-7.noarch.rpm
fi

if ! rpm -q puppet-tools-release &>/dev/null; then
  echo "Installing puppet-tools-release RPM"
  yum install -y https://yum.puppet.com/puppet-tools-release-el-7.noarch.rpm
fi

if ! rpm -q epel-release &>/dev/null; then
  echo "Installating epel repository"
  #yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
  yum install -y epel-release
fi

if ! rpm -q puppet-agent &>/dev/null; then
  echo "Installating puppet-agent"
  yum install -y puppet-agent
fi
