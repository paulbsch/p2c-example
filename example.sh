#!/bin/bash

if [ -n "$@" ]; then
    "$@"
fi

if [ -x /usr/sbin/sshd-keygen ]; then
    /usr/sbin/sshd-keygen
else
    ssh-keygen -q -f /etc/ssh/ssh_host_key -N '' -t rsa1
    ssh-keygen -q -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
    ssh-keygen -q -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
    ssh-keygen -q -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
    ssh-keygen -q -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519
fi
[ ! -d /var/run/sshd ] && mkdir -p /var/run/sshd
[ -x /usr/sbin/sshd ] && /usr/sbin/sshd -D

