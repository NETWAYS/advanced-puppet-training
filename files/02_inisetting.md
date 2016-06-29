!SLIDE subsectionnonum
# ini_setting

!SLIDE smbullets
# ini_setting Overview

* Manages settings in an ini file (or similar)
* Custom resource types and function
* Included in puppetlabs/inifile modules


!SLIDE smbullets small
# ini_setting Usage

    @@@ Puppet
    ini_setting {'Java Home':
      ensure            => present,
      section           => '',
      key_val_separator => '=',
      path              => '/etc/sysconfig/tomcat',
      setting           => 'JAVA_HOME',
      value             => '/usr/lib/jvm/java-1.8.0',
    }

    ini_subsetting {'Java Memory Max':
      ensure            => present,
      section           => '',
      key_val_separator => '=',
      path              => '/etc/sysconfig/tomcat',
      setting           => 'JAVA_OPTS',
      subsetting        => '-Xmx',
      value             => '512m',
    }

Results in:

    JAVA_HOME="/usr/lib/jvm/java-1.8.0"
    JAVA_OPTS="-Xmx 512m -Xms 128m"
