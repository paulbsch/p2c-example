#!/bin/bash

apiurl=$1
apiuser=$2
apikey=$3

echo "apiurl=$apiurl" >/tmp/apiurl

. /etc/JARVICE/jobinfo.sh

cat <<EOF | sudo tee /usr/local/bin/shutdown >/dev/null
#!/bin/sh

curl "https://api.jarvice.com:443/jarvice/shutdown" \
    --data-urlencode "name=$JOB_NAME" \
    --data-urlencode "username=$apiuser" \
    --data-urlencode "apikey=$apikey"
EOF
sudo chmod 755 /usr/local/bin/shutdown

sudo /usr/lib/systemd/systemd --switched-root --system &

touch /tmp/tail
tail -f /tmp/tail

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

