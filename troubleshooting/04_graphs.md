!SLIDE smbullets
# Dependency graphs

* Dependency as *dot* graphs:
 * On every run with `graph` set to *true*
 * On demand with `puppet catalog` command
 * During development `puppet apply` command
* Rendered as image with graphviz
* Needs often manual tweaking

~~~SECTION:handouts~~~

****

Quite usefully for finding dependency cycles or missing dependencies is Puppet's capability to render *dot* files.
Typically it is not necessary to render them on every run instead render them on demand. During development you can
add the parameter `--graph` to the `puppet apply` command which will give you a small and handy graph. Later on you
can render a graph for the complete configuration with `puppet catalog --render-as dot find agent > agent.dot`, but
this graph will be huge.

The *dot* file can then be rendered as an image using graphviz by simply running `graphiz -Tpng agent.dot -o agent.png`.

Often you will be required to manually tweak the *dot* file to adjust names and labels or to simplify the graph.

~~~ENDSECTION~~~


!SLIDE smbullets
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Dependency graph

* Objective:
 * Render an image of the dependencies of your Puppet code
* Steps:
 * Render the *dot* file from the catalog `puppet.localdomain`
 * Render a image from the *dot* file
 * Transfer it to your laptop to view the graph


!SLIDE supplemental exercises
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Dependency graph

## Objective:

****

* Render an image of the dependencies of your Puppet code

## Steps:

****

* Render the *dot* file from the catalog of a system of your choice on `puppet.localdomain`

Command is `puppet catalog --render-as dot find agent > agent.dot` where agent is replaced by the system's certificate name.

* Render a image from the *dot* file

Command is `dot -Tpng agent.dot -o agent.png`

* Transfer it to your laptop to view the graph


!SLIDE supplemental solutions
# Lab ~~~SECTION:MAJOR~~~.~~~SECTION:MINOR~~~: Proposed Solution

****

## Dependency graph

****

Render the *dot* file from the catalog of a system of your choice on `puppet.localdomain`:

    @@@Sh
    $ sudo yum install graphviz
    $ puppet catalog --render-as dot find agent-centos.localdomain > /tmp/agent.dot

Render a image from the *dot* file:

    @@@Sh
    $ sed -i -e "1d" /tmp/agent.dot
    $ dot -Tpng /tmp/agent.dot -o /tmp/agent.png

Transfer it to your laptop to view the graph:
    @@@Sh
    $ scp /tmp/agent.png root@192.168.56.1:/tmp/

Afterwards open it with an image viewer installed on the laptop.
