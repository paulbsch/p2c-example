#!/bin/bash

if [ -n "$@" ]; then
    "$@"
fi

if [ -x /usr/sbin/sshd-keygen ]; then
    /usr/sbin/sshd-keygen
else
    [ ! -f /etc/ssh/ssh_host_key ] && \
        sudo ssh-keygen -q -f /etc/ssh/ssh_host_key -N '' -t rsa1
    [ ! -f /etc/ssh/ssh_host_rsa_key ] && \
        sudo ssh-keygen -q -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
    [ ! -f /etc/ssh/ssh_host_dsa_key ] && \
        sudo ssh-keygen -q -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
    [ ! -f /etc/ssh/ssh_host_ecdsa_key ] && \
        sudo ssh-keygen -q -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
    [ ! -f /etc/ssh/ssh_host_ed25519_key ] && \
        sudo ssh-keygen -q -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519
fi
[ ! -d /var/run/sshd ] && \
    mkdir -p /var/run/sshd && chown root:root /var/run/sshd
[ -x /usr/sbin/sshd ] && /usr/sbin/sshd -D

