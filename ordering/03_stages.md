!SLIDE small
# Run Stages

* Allow for specific ordering of a class during runtime
* Are declared as resources
* Use existing relationship syntax
* There is always an implied stage called `main`
* Stage `main` is the default stage for all classes
* Only entire classes can be put in a run stage


!SLIDE small
# Declare Stages

Metaparameters:

    @@@ Puppet
    class stages {
      stage { 'before':
        before => Stage['main'],
      }

      stage { 'after':
        require => Stage['main'],
      }
    }

Chaining arrows:

    @@@ Puppet
    class stages {
      stage { [ 'before', 'after']: }

      Stage['before'] -> Stage['main'] -> Stage['after']
    }


!SLIDE small
# Assign Classes to Stages

    @@@ Puppet
    class webserver {
      include stages
      include packages # Gets Stage['main'] by default

      class { 'yum':
        stage => 'before',
      }

      class { 'apache':
        stage => 'after',
      }
    }
