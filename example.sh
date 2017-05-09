#!/bin/bash

apiurl=$1
apiuser=$2
apikey=$3

cat >/usr/local/bin/shutdown <<EOF
#!/bin/sh

. /etc/JARVICE/jobinfo.sh
curl "https://api.jarvice.com:443/jarvice/shutdown" \
    --data-urlencode "name=$JOB_NAME" \
    --data-urlencode "username=$apiuser" \
    --data-urlencode "apikey=$apikey"
EOF
chmod 755 /usr/local/bin/shutdown

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

