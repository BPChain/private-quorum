#!/bin/bash
cd /root/files || exit
/root/files/geth --datadir=~/.ethereum/devchain init "/root/files/blockchain_files/genesis.json"
./geth --datadir=~/.ethereum/devchain --password <(echo -n 123)  account new
BOOTSTRAP_IP=`getent hosts bootstrap | cut -d" " -f1`
GETH_OPTS=${@/IPAddress/$BOOTSTRAP_IP}
python3 /root/files/node &
./geth $GETH_OPTS & cd /root/files/METAScenario;node startMigration.js & cd /root/files;node chain_configuration.js
