On both systems:
sudo `userdel -r vagrant`

Run on agent:
rpm -qa | grep puppet
sudo yum remove puppet
sudo yum remove puppet6-release-6.0.0-5.el7.noarch
sudo yum remove puppet-tools-release-1.0.0-1.el7.noarch
history -cw
