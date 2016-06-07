!SLIDE small
# Developing Facts

    @@@ Sh
    # tree /etc/puppet/modules/{MODULE NAME}
    |-- lib
    |   |-- facter
    |   |   `-- role.rb

* By convention, the file name has to match the name of the fact
* Multiple facts can be distributed with a single module


Test facts locally by setting FACTERLIB or RUBYLIB environment variables:

    @@@ Sh
    # export RUBYLIB=/etc/puppet/modules/custom/lib
    # facter role
    Apache Webserver
