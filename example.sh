#!/bin/bash

if [ -x /usr/sbin/sshd ]; then
    /usr/sbin/sshd-keygen && /usr/sbin/sshd
fi

if [ -n "$1" ]; then
    $1
fi

