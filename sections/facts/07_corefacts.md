!SLIDE small
# Fact overview

There are different kind of facts:

* Core Facts devided into
  * Modern facts and
  * Legacy facts
* Other facts
  * trusted facts
  * server facts

It is recommended to use the modern facts. As of Facter 3, legacy facts are even hidden from the basic facter command-line output.

Modern facts contain legacy facts. easy example:
The legacy fact `domain` is now included in the hashed modern fact `networking` and can be accessed accordingly:
`facter networking.domain` or in terms of puppet `${::facts['networking']['domain']}`

Learn more about core facts here: https://puppet.com/docs/facter/latest/core_facts.html

While normal facts are self reported by the node, trusted facts prove that the certificate authority checked them. This is extremely useful if there is rather sensitive data contained in the catalog.
