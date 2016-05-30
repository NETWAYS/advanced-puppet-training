!SLIDE smbullets small
# Functions

<pre>
class apache::params {
  case $::osfamily {
    ...
    default: {
      fail('Your operatingsystem is not supported, yet.')
    }
  }
}
