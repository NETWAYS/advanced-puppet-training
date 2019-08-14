!SLIDE subsectionnonum
# ini_setting


!SLIDE smbullets
# ini_setting Overview

* Manages settings in an ini file (or similar)
* Custom resource types and function
* Included in puppetlabs/inifile modules


!SLIDE smbullets small
# ini_setting Usage

    @@@Puppet
    ini_setting {'Java Home':
      ensure            => present,
      section           => 'Date',
      key_val_separator => '=',
      path              => '/etc/php/7.2/apache2/php.ini',
      setting           => 'date.timezone',
      value             => 'US/Pacific',
    }

Results in:

    @@@ini
    ...
    [Date]
    ; Defines the default timezone used by the date functions
    ; http://php.net/date.timezone
    date.timezone = US/Pacific
    ...
