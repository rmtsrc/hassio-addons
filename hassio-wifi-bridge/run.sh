#!/bin/bash

date
echo "hassio-wifi-bridge starting..."

CONFIG_PATH=/data/options.json
SSH_KEY=$(jq --raw-output ".sshDevPrivateKey" $CONFIG_PATH)
WIFI_ADAPTOR=$(jq --raw-output ".wifiAdaptor" $CONFIG_PATH)
ETH_ADAPTOR=$(jq --raw-output ".ethernetAdaptor" $CONFIG_PATH)
ADDRESS=$(jq --raw-output ".address" $CONFIG_PATH)
NETMASK=$(jq --raw-output ".netmask" $CONFIG_PATH)
BROADCAST=$(jq --raw-output ".broadcast" $CONFIG_PATH)

# Enforces required env variables
required_vars=(SSH_KEY WIFI_ADAPTOR ETH_ADAPTOR ADDRESS NETMASK BROADCAST)
for required_var in "${required_vars[@]}"; do
  if [[ -z ${!required_var} ]]; then
    error=1
    echo >&2 "Error: $required_var env variable not set."
  fi
done

if [[ -n $error ]]; then
  exit 1
fi

# Setup interface
echo "Setting up interface..."

nmcli dev set $ETH_ADAPTOR managed no

echo "iface $ETH_ADAPTOR inet static" >>/etc/network/interfaces
echo "address $ADDRESS" >>/etc/network/interfaces
echo "netmask $NETMASK" >>/etc/network/interfaces
echo "broadcast $BROADCAST" >>/etc/network/interfaces

ifdown $ETH_ADAPTOR >/dev/null 2>&1
ifup $ETH_ADAPTOR

# Setup ssh key
mkdir ~/.ssh
sed 's/\\n/\'$'\n''/g' <<<$SSH_KEY >~/.ssh/ha_dev
chmod 600 ~/.ssh/ha_dev

# Run on iptables host
ssh -o StrictHostKeyChecking=no root@127.0.0.1 -p 22222 -i ~/.ssh/ha_dev " \
iptables -t nat -A POSTROUTING -o $WIFI_ADAPTOR -j MASQUERADE && \
iptables -A FORWARD -i $WIFI_ADAPTOR -o $ETH_ADAPTOR -m state --state RELATED,ESTABLISHED -j ACCEPT && \
iptables -A FORWARD -i $ETH_ADAPTOR -o $WIFI_ADAPTOR -j ACCEPT \
"

echo "Done"

wait ${!}
