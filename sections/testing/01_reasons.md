!SLIDE smbullets
# Why Test Code?

* Confirm that code updates don't break anything
* Ensure that platform changes are accounted for
* Avoid committing broken code to your repository
* Helps maintain good programming practice


!SLIDE smbullets
# Kinds of Tests

* Unit Tests:
 * Test the smallest unit of functionality
 * As simple as possible, easy to debug and reliable
 * Prove that each part of the code works on its own
* Integration Tests:
 * Combine units and test the entire system
 * Validate that all parts work together
 * Only test the whole system, not individual parts
* Functional and Acceptance Tests:
 * Compare end results with specification
 * Only test end results, not intermediate state


!SLIDE small
# Why Test Puppet Modules?


**Question:** Does testing just duplicate smoke tests in another language?


**Answer:** Only for simple manifests!


Tests become invaluable when your manifests:

* Include dynamic content from templates
* Support multiple operating systems
* Take different actions when passed parameters

Unit tests will help you:

* Protect against regressions when refactoring
* Trust in major module or Puppet upgrades
