#!/usr/bin/env bats

@test 'sets hostname to "test"' {
    if [ `uname` == 'FreeBSD' ] ; then
        run hostname -s
    else
        run hostname
    fi
    [ "$output" = 'test' ]
}

@test 'sets FQDN to "test.example.com"' {
    run hostname -f
    [ "$output" = 'test.example.com' ]
}

@test 'sets dnsdomainname to "example.com"' {
    if [ `uname` == 'FreeBSD' ] ; then
        skip "FreeBSD has no dnsdomainname"
    fi
    run dnsdomainname
    [ "$output" = 'example.com' ]
}
