# DESCRIPTION:

Sets hostname and FQDN of the node.

# ATTRIBUTES:

`set_fqdn` - FQDN to set.

The asterisk character will be replaced with `node.name`. This way,
you can add to base role this:

```ruby
default_attributes :set_fqdn => '*.project-domain.com'
```

and have node set its FQDN and hostname based on its chef node name
(which is provided on `chef-client` first run's command line).

# RECIPES:

## default

Will set node's FQDN to value of `set_fqdn` attribute, and hostname to
its host part (up to first dot).

## vmware

`hostname::vmware` recipe sets hostname automatically using vmtoolsd.
You do not need to set node["set_fqdn"].

The latest code is hosted at https://github.com/3ofcoins/chef-cookbook-hostname
