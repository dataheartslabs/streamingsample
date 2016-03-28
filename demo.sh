#!/usr/bin/env bash

bin=`which $0`
bin=`dirname $bin`
INSTALL_DIR=`cd "$bin"; pwd`

$INSTALL_DIR/kibana4_daemon.sh stop > /dev/null 2>&1
curl -XPOST 'http://localhost:9200/_cluster/nodes/_local/_shutdown' > /dev/null 2>&1
rm -rf /usr/share/elasticsearch/
rm -rf /opt/kibana/
mkdir /usr/share/elasticsearch
tar xvf elasticsearch-1.4.4.tar.gz > /dev/null 2>&1
cp -R elasticsearch-1.4.4/* /usr/share/elasticsearch/
cd /usr/share/elasticsearch
bin/plugin -install transport-couchbase -url file://$INSTALL_DIR/elasticsearch-transport-sponge-2.0.0.zip
bin/plugin -install head -url file://$INSTALL_DIR/mobz-elasticsearch-head-7db19b1.zip
echo "couchbase.password: password" >> config/elasticsearch.yml ; echo "couchbase.username: Administrator" >> config/elasticsearch.yml
bin/elasticsearch&
sleep 10
iptables -F
mkdir -p /opt/kibana
tar xvf kibana-4.0.1-linux-x64.tar.gz > /dev/null 2>&1
cp -R /home/vagrant/download/kibana-4.0.1-linux-x64/* /opt/kibana/
$INSTALL_DIR/kibana4_daemon.sh start
sleep 5
curl -XPUT http://localhost:9200/_template/sponge -d @$INSTALL_DIR/sponge-template.json
curl -XPUT http://localhost:9200/traffic
sleep 2
/etc/init.d/sponge-server stop
rm /opt/sponge/config/config.dat
/etc/init.d/sponge-server start

