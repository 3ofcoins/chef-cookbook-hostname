#!/usr/bin/env bats

@test 'sets hostname to "test"' {
  run hostname
  [ "$output" = 'test' ]
}

@test 'sets FQDN to "test.example.com"' {
  run hostname -f
  [ "$output" = 'test.example.com' ]
}

@test 'sets dnsdomainname to "example.com"' {
  run dnsdomainname
  [ "$output" = 'example.com' ]
}
