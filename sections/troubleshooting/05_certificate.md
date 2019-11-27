!SLIDE small
# Certificate Time

    @@@Sh
    $ cd /etc/puppetlabs/puppet/ssl
    $ sudo openssl x509 -in certs/agent-centos.localdomain.pem \
      -noout -dates
    notBefore=Oct 15 15:19:53 2017 GMT
    notAfter=Oct 15 15:19:53 2017 GMT

* Certificate creation is based on Master's clock
* Default validity period is 5 years from creation
* Puppet 3.x and higher shows certificate expiration warnings
