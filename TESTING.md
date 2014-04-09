Testing
=======

Preparation
-----

    $ bundle install

And then, to install all cookbooks:

    $ bundle exec berks install

Local
-----

    $ bundle exec strainer test

The above runs:

 - `knife cookbook test` tests
 - Food Critic lint
 - Chefspec tests

Chefspec tests (the interesting part) are in `spec/`.

Integration
-----------

    $ bundle exec kitchen test
 
 See `.kitchen.yml` and `test/` directory for details.
