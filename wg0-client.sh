#!/usr/bin/zsh

cd /etc/wireguard/
umask 077; wg genkey | tee privatekey | wg pubkey > publickey

cat <<-EOF > /etc/wireguard/wg0.conf
[Interface]
PrivateKey = `cat ./privatekey`
## Client IP
Address = $1/24
## if you have DNS server running
# DNS = 192.168.11.1
[Peer]
PublicKey = gK5aD+6MQHc4nz106Vb2mV8vommyPhSX++67shoRZG4=
## to pass internet trafic 0.0.0.0 but for peer connection only use 192.168.11.0/24, or
AllowedIPs = 0.0.0.0/0
Endpoint = 192.168.0.183:51820
PersistentKeepalive = 20
EOF
echo "wg set wg0 peer `cat publickey` allowed-ips $1/32"
