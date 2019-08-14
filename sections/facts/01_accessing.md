!SLIDE small
# Accessing Facts

    @@@Puppet
    class system {
      $facts['operatingsystem'] = 'OzzyOS'
      notify { "Your operatingsystem is: ${::facts['operatingsystem']}" }
    }

    notice: Your operatingsystem is: CentOS

    class system {
      $facts['operatingsystem'] = 'OzzyOS'
      notify { "Your operatingsystem is: ${facts['operatingsystem']}" }
    }

    notice: Your operatingsystem is: OzzyOS

* Facts are exposed as top scope variables
* Fact references should always contain a top scope reference
