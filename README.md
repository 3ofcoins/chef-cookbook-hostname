# DESCRIPTION:

Sets hostname and FQDN of the node.

# ATTRIBUTES:

set_fqdn - FQDN to set

# RECIPES:

## default

## vmware

`hostname::vmware` recipe sets hostname automatically using vmtoolsd.
You do not need to set node["set_fqdn"].

The latest code is hosted at https://github.com/3ofcoins/chef-cookbook-hostname
