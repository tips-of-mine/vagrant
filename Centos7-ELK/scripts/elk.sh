#!/bin/bash

echo '.'
echo ' /$$$$$$ /$$   /$$  /$$$$$$  /$$$$$$$$ /$$$$$$  /$$       /$$        /$$$$$$  /$$$$$$$$ /$$$$$$  /$$$$$$  /$$   /$$'
echo '|_  $$_/| $$$ | $$ /$$__  $$|__  $$__//$$__  $$| $$      | $$       /$$__  $$|__  $$__/|_  $$_/ /$$__  $$| $$$ | $$'
echo '  | $$  | $$$$| $$| $$  \__/   | $$  | $$  \ $$| $$      | $$      | $$  \ $$   | $$     | $$  | $$  \ $$| $$$$| $$'
echo '  | $$  | $$ $$ $$|  $$$$$$    | $$  | $$$$$$$$| $$      | $$      | $$$$$$$$   | $$     | $$  | $$  | $$| $$ $$ $$'
echo '  | $$  | $$  $$$$ \____  $$   | $$  | $$__  $$| $$      | $$      | $$__  $$   | $$     | $$  | $$  | $$| $$  $$$$'
echo '  | $$  | $$\  $$$ /$$  \ $$   | $$  | $$  | $$| $$      | $$      | $$  | $$   | $$     | $$  | $$  | $$| $$\  $$$'
echo ' /$$$$$$| $$ \  $$|  $$$$$$/   | $$  | $$  | $$| $$$$$$$$| $$$$$$$$| $$  | $$   | $$    /$$$$$$|  $$$$$$/| $$ \  $$'
echo '|______/|__/  \__/ \______/    |__/  |__/  |__/|________/|________/|__/  |__/   |__/   |______/ \______/ |__/  \__/'
echo '.'

echo '.'
echo ' /$$$$$$$$ /$$        /$$$$$$   /$$$$$$  /$$$$$$$$ /$$$$$$  /$$$$$$   /$$$$$$  /$$$$$$$$  /$$$$$$  /$$$$$$$   /$$$$$$  /$$   /$$'
echo '| $$_____/| $$       /$$__  $$ /$$__  $$|__  $$__/|_  $$_/ /$$__  $$ /$$__  $$| $$_____/ /$$__  $$| $$__  $$ /$$__  $$| $$  | $$          /$$'
echo '| $$      | $$      | $$  \ $$| $$  \__/   | $$     | $$  | $$  \__/| $$  \__/| $$      | $$  \ $$| $$  \ $$| $$  \__/| $$  | $$         | $$'
echo '| $$$$$   | $$      | $$$$$$$$|  $$$$$$    | $$     | $$  | $$      |  $$$$$$ | $$$$$   | $$$$$$$$| $$$$$$$/| $$      | $$$$$$$$       /$$$$$$$$'
echo '| $$__/   | $$      | $$__  $$ \____  $$   | $$     | $$  | $$       \____  $$| $$__/   | $$__  $$| $$__  $$| $$      | $$__  $$      |__  $$__/'
echo '| $$      | $$      | $$  | $$ /$$  \ $$   | $$     | $$  | $$    $$ /$$  \ $$| $$      | $$  | $$| $$  \ $$| $$    $$| $$  | $$         | $$'
echo '| $$$$$$$$| $$$$$$$$| $$  | $$|  $$$$$$/   | $$    /$$$$$$|  $$$$$$/|  $$$$$$/| $$$$$$$$| $$  | $$| $$  | $$|  $$$$$$/| $$  | $$         |__/'
echo '|________/|________/|__/  |__/ \______/    |__/   |______/ \______/  \______/ |________/|__/  |__/|__/  |__/ \______/ |__/  |__/'
echo ' '
echo '/$$   /$$ /$$$$$$ /$$$$$$$   /$$$$$$  /$$   /$$  /$$$$$$'
echo '| $$  /$$/|_  $$_/| $$__  $$ /$$__  $$| $$$ | $$ /$$__  $$          /$$'
echo '| $$ /$$/   | $$  | $$  \ $$| $$  \ $$| $$$$| $$| $$  \ $$         | $$'
echo '| $$$$$/    | $$  | $$$$$$$ | $$$$$$$$| $$ $$ $$| $$$$$$$$       /$$$$$$$$'
echo '| $$  $$    | $$  | $$__  $$| $$__  $$| $$  $$$$| $$__  $$      |__  $$__/'
echo '| $$\  $$   | $$  | $$  \ $$| $$  | $$| $$\  $$$| $$  | $$         | $$'
echo '| $$ \  $$ /$$$$$$| $$$$$$$/| $$  | $$| $$ \  $$| $$  | $$         |__/'
echo '|__/  \__/|______/|_______/ |__/  |__/|__/  \__/|__/  |__/'
echo ' '
echo ' /$$        /$$$$$$   /$$$$$$   /$$$$$$  /$$$$$$$$ /$$$$$$   /$$$$$$  /$$   /$$'
echo '| $$       /$$__  $$ /$$__  $$ /$$__  $$|__  $$__//$$__  $$ /$$__  $$| $$  | $$'
echo '| $$      | $$  \ $$| $$  \__/| $$  \__/   | $$  | $$  \ $$| $$  \__/| $$  | $$'
echo '| $$      | $$  | $$| $$ /$$$$|  $$$$$$    | $$  | $$$$$$$$|  $$$$$$ | $$$$$$$$'
echo '| $$      | $$  | $$| $$|_  $$ \____  $$   | $$  | $$__  $$ \____  $$| $$__  $$'
echo '| $$      | $$  | $$| $$  \ $$ /$$  \ $$   | $$  | $$  | $$ /$$  \ $$| $$  | $$'
echo '| $$$$$$$$|  $$$$$$/|  $$$$$$/|  $$$$$$/   | $$  | $$  | $$|  $$$$$$/| $$  | $$'
echo '|________/ \______/  \______/  \______/    |__/  |__/  |__/ \______/ |__/  |__/'
echo '.'

echo '.'     
echo '**********************'
echo '* INSTALLATION: Debut paramétrage'
echo '**********************'
echo '.'
echo ' - Installation'

java -version

sudo mv /Vagrantfiles/GeoIP.conf /etc/GeoIP.conf

geoipupdate

sudo mv /Vagrantfiles/geoipupdate /etc/cron.weekly/geoipupdate

echo '.'     
echo '**********************'
echo '* INSTALLATION: Fin paramétrage'
echo '**********************'
echo '.'

echo '.'     
echo '**********************'
echo '* INSTALLATION: Debut elasticsearch'
echo '**********************'
echo '.'

sudo mv /Vagrantfiles/elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo

rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

yum clean all && yum makecache

yum install elasticsearch -y

rpm -qi elasticsearch

systemctl daemon-reload && systemctl enable elasticsearch && systemctl start elasticsearch

netstat -plntu

curl http://localhost:9200

curl -X PUT "http://127.0.0.1:9200/mytest_index"

echo '.'
echo '**********************'
echo '* INSTALLATION: Fin elasticsearch'
echo '**********************'
echo '.'

echo '.'
echo '**********************'
echo '* INSTALLATION: Debut kibana'
echo '**********************'
echo '.'

yum install kibana -y

sudo mv /Vagrantfiles/kibana.yml /etc/kibana/kibana.yml

systemctl daemon-reload && systemctl enable kibana && systemctl start kibana

netstat -plntu

echo '.'
echo '**********************'
echo '* INSTALLATION: Fin kibana'
echo '**********************'
echo '.'

echo '.'
echo '**********************'
echo '* INSTALLATION: Debut logstash'
echo '**********************'
echo '.'

yum install logstash -y

cd /etc/logstash/conf.d

wget https://raw.githubusercontent.com/a3ilson/pfelk/master/conf.d/01-inputs.conf
wget https://raw.githubusercontent.com/a3ilson/pfelk/master/conf.d/05-syslog.conf
wget https://raw.githubusercontent.com/a3ilson/pfelk/master/conf.d/10-pf.conf
wget https://raw.githubusercontent.com/a3ilson/pfelk/master/conf.d/11-firewall.conf
wget https://raw.githubusercontent.com/a3ilson/pfelk/master/conf.d/50-outputs.conf

mkdir -p /etc/logstash/conf.d/patterns && cd /etc/logstash/conf.d/patterns

wget https://raw.githubusercontent.com/a3ilson/pfelk/master/conf.d/patterns/pf-09.2019.grok

systemctl daemon-reload && systemctl enable logstash && systemctl start logstash

echo '.'
echo '**********************'
echo '* INSTALLATION: Fin logstash'
echo '**********************'
echo '.'

echo '.'
echo '**********************'
echo '* INSTALLATION: Debut divers'
echo '**********************'
echo '.'

yum install filebeat auditbeat metricbeat packetbeat heartbeat-elastic -y

systemctl daemon-reload && systemctl enable filebeat && systemctl start filebeat
systemctl daemon-reload && systemctl enable auditbeat && systemctl start auditbeat
systemctl daemon-reload && systemctl enable metricbeat && systemctl start metricbeat
systemctl daemon-reload && systemctl enable packetbeat && systemctl start packetbeat
systemctl daemon-reload && systemctl enable heartbeat-elastic && systemctl start heartbeat-elastic

systemctl status elasticsearch
systemctl status kibana
systemctl status logstash

echo '.'
echo '**********************'
echo '* INSTALLATION: Debut divers'
echo '**********************'
echo '.'

echo '.'
echo '**********************'
echo '* INSTALLATION: Debut Firewall'
echo '**********************'
echo '.'

firewall-cmd --permanent --zone=public --add-port=5044/tcp
firewall-cmd --permanent --zone=public --add-port=5140/tcp
firewall-cmd --permanent --zone=public --add-port=5140/udp
firewall-cmd --permanent --zone=public --add-port=5601/tcp
firewall-cmd --reload

echo '.'
echo '**********************'
echo '* INSTALLATION: Fin Firewall'
echo '**********************'
echo '.'

cat > /etc/motd << EOF

 /$$$$$$$$ /$$$$$$ /$$$$$$$   /$$$$$$           /$$$$$$  /$$$$$$$$      /$$      /$$ /$$$$$$ /$$   /$$ /$$$$$$$$
|__  $$__/|_  $$_/| $$__  $$ /$$__  $$         /$$__  $$| $$_____/     | $$$    /$$$|_  $$_/| $$$ | $$| $$_____/
   | $$     | $$  | $$  \ $$| $$  \__/        | $$  \ $$| $$           | $$$$  /$$$$  | $$  | $$$$| $$| $$
   | $$     | $$  | $$$$$$$/|  $$$$$$  /$$$$$$| $$  | $$| $$$$$ /$$$$$$| $$ $$/$$ $$  | $$  | $$ $$ $$| $$$$$
   | $$     | $$  | $$____/  \____  $$|______/| $$  | $$| $$__/|______/| $$  $$$| $$  | $$  | $$  $$$$| $$__/
   | $$     | $$  | $$       /$$  \ $$        | $$  | $$| $$           | $$\  $ | $$  | $$  | $$\  $$$| $$
   | $$    /$$$$$$| $$      |  $$$$$$/        |  $$$$$$/| $$           | $$ \/  | $$ /$$$$$$| $$ \  $$| $$$$$$$$
   |__/   |______/|__/       \______/          \______/ |__/           |__/     |__/|______/|__/  \__/|________/

Bienvenue dans la version Centos 7 Elasticsearch.Kibana.Logstack

 - Elasticsearch, Kibana and Logstack

To test your environment is correctly working, just open following URL from your Host OS:
http://localhost/info.php

EOF
