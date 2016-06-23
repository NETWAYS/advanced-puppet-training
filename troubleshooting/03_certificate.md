!SLIDE small
# Certificate Time

    @@@ Sh
    # cd /etc/puppet/ssl/certs
    openssl x509 -in master.training.vm.pem -noout -dates
    notBefore=Oct 15 15:19:53 2017 GMT
    notAfter=Oct 15 15:19:53 2017 GMT

    err: Could not retrieve catalog from remote server: SSL_connect
      returned=1 errno=0 state=SSLv3 read server certificate B: 
      certificate verify failed. This is often because the time is 
      out of sync on the server or client
    warning: Not using cache on failed catalog
    err: Could not send report: SSL_connect returned=1 errno=0 
      state=SSLv3 read server certificate B: certificate verify 
      failed. This is often because the time is out of sync on 
      the server or client

* Certificate creation is based on Master's clock
* Default validity period is 5 years from creation
* Puppet 3.x and higher shows certificate expiration warnings
