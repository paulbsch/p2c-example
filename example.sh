#!/bin/bash

if [ -n "$@" ]; then
    "$@"
fi

[ -x /usr/sbin/sshd-keygen ] && /usr/sbin/sshd-keygen  # if CentOS
[ -x /usr/sbin/sshd ] && /usr/sbin/sshd -D

