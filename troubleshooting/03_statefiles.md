!SLIDE smbullets
# Statefiles on the agent

* Assigned classes and resources
 * *classes.txt*
 * *resources.txt*
* Status of the last run
 * *last_run_summary.yaml*
 * *last_run_report.yaml*
* Complete catalog as json

~~~SECTION:handouts~~~

****

Puppet writes on every agent some statefiles which are quite helpful for debugging.

In the statedir it creates the files *classes.txt* containing all classes assign to the host including all
not directly assigned ones. The *resources.txt* contains all resources managed by Puppet. A summary of
the last run represented as yaml can be found in *last_run_summary.yaml* including count of failed resources
and events and timing for resource types. The *last_run_report.yaml* adds even more details to it.

Furthermore in the client_datadir you can find the complete catalog in json format as it is used by the agent.
If files are sourced from the Puppet master you can not use it directly for testing with apply, but it helps
to find problems even if it is used only as source of information or for comparision with a manually compiled
catalog from the master.

~~~ENDSECTION~~~
