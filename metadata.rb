name             "hostname"
maintainer       "Maciej Pasternacki"
maintainer_email "maciej@pasternacki.net"
license          "MIT"
description      "Configures hostname and FQDN"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

supports "debian"
supports "ubuntu"

depends "hostsfile"
