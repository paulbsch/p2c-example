#!/bin/bash

if [ -n "$@" ]; then
    echo "$@" >/tmp/args.txt
fi

if [ -x /usr/sbin/sshd-keygen ]; then
    sudo /usr/sbin/sshd-keygen
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
[ ! -d /var/run/sshd ] && sudo mkdir -p /var/run/sshd
[ -x /usr/sbin/sshd ] && sudo /usr/sbin/sshd -D

