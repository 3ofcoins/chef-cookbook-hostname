# Change History

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
