!SLIDE small
# Adding Functions

A custom **:statement** function:

    @@@Ruby
    Puppet::Functions.create_function(:myfunc) do |args|
      ...
    end

A custom **:rvalue** function:

    @@@Ruby
    Puppet::Functions.create_function(:myfunc), \
      type => :rvalue do |args|
      ...
    end

It will always return the output of the last line executed
