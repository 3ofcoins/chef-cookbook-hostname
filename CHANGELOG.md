# Change History

0.4.0 (2015-03-16)
==================
 - #40: Use file resources with lazy eval and notifies to prevent network restarts from occurring on every chef run (Matt Kasa)
 - Add box with Ubuntu 14.04 for kitchen tests
 - #27: Update default recipe to reload only the hostname plugin instead of ohai (Jonathan Serafini)

0.3.0 (2014-05-20)
==================
 - Fixed (and tested) FreeBSD support
 - #17: added support for RedHat & CentOS (Damien Roche, Marta Paciorkowska)
 - added instructions on manual testing with reboot (Marta Paciorkowska)

0.2.0
=====
 - Refresh and fix tests, add Rubocop style checks (Marta Paciorkowska)
 - #16: do not remove existing /etc/hosts entries on 127.0.0.1, use
   configurable IP for hostname entry we need to have for ourselves
   (Jean Mertz, Marta Paciorkowska)

0.1.0
=====
 - Tests: chefspec, test-kitchen
 - Substitute `*` in `set_fqdn` with `node.name` to allow fully
   automatic FQDN setup.

0.0.6
=====
 - Clean up backup files from community.opscode.com release

0.0.5
=====
 - Added change log
 - `metadata.rb` explicitly states cookbook name (Chulki Lee)
 - New recipe `hostname::vmware` (tily)
 - Use hostsfile cookbook to manipulate `/etc/hosts`, use 127.0.1.1
   instead of trying to figure out own IP (Guilhem Lettron)
   
0.0.4
=====
 - Use attribute levels when setting for Chef 11 compatibility (Alan
   Wilhelm)

0.0.3
=====
 - Syntax fix for compatibility with Ruby 1.9.2

0.0.2 and before
================

This is prehistory.
