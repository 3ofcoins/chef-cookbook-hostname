name             "hostname"
maintainer       "Maciej Pasternacki"
maintainer_email "maciej@pasternacki.net"
license          "MIT"
description      "Configures hostname and FQDN"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.1"

supports "debian"
supports "ubuntu"
supports "freebsd"
supports "centos"
supports "redhat"

depends "hostsfile"
