#!/bin/bash

yum -t -y -e 0 remove facter hiera puppet
rm -Rf /etc/puppet
rm -Rf /var/lib/puppet
