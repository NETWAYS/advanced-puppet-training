!SLIDE noprint
# Puppet Run Cycle

<center><img src="./_images/puppet_workflow.png" style="width:516px;height:456px;" alt="Workflow"/></center>


!SLIDE printonly
# Puppet Run Cycle

<center><img src="./_images/puppet_workflow.png" style="width:470px;height:418px;" alt="Workflow"/></center>

~~~SECTION:handouts~~~

****

~~~PAGEBREAK~~~

1. **Facts:** The node sends data about its state to the puppet master server.
2. **Catalog:** Puppet uses the facts to compile a Catalog that specifies how the node should be configured.
3. **Report:** Configuration changes are reported back to the Puppet Master.
4. **Report:** Puppet's open API can also send data to 3rd party tools.

~~~ENDSECTION~~~
