!SLIDE small
# Adding Functions

A custom **:statement** function:

    @@@ Ruby
    Puppet::Parser::Functions.newfunction(:myfunc) do |args|
      ...
    end

A custom **:rvalue** function:

    @@@ Ruby
    Puppet::Parser::Functions.newfunction(:myfunc), \
      type => :rvalue do |args|
      ...
    end
