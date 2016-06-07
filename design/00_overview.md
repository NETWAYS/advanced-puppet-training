!SLIDE subsection
# ~~~SECTION:MAJOR~~~ Module Design


!SLIDE small
# Good Module Design

* Only manage their own resources
 * Don't manage logrotating in your `apache` module
 * What happens if your `drupal` module manages Apache and PHP?
* Be granular, portable and reusable
* Avoid exposing implementation details


!SLIDE small
# Architecting Modules

Motivation:

* Huge applications to manage, such as Apache or Tomcat
* A lot of code lines
* Complex dependency structures
* Some examples:
 * puppetlabs/apache
 * camptocamp/tomcat
