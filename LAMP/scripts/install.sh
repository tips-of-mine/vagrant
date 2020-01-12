#!/bin/bash

echo '.'
echo ' /$$$$$$$$ /$$$$$$ /$$$$$$$   /$$$$$$           /$$$$$$  /$$$$$$$$      /$$      /$$ /$$$$$$ /$$   /$$ /$$$$$$$$'
echo '|__  $$__/|_  $$_/| $$__  $$ /$$__  $$         /$$__  $$| $$_____/     | $$$    /$$$|_  $$_/| $$$ | $$| $$_____/'
echo '   | $$     | $$  | $$  \ $$| $$  \__/        | $$  \ $$| $$           | $$$$  /$$$$  | $$  | $$$$| $$| $$      '
echo '   | $$     | $$  | $$$$$$$/|  $$$$$$  /$$$$$$| $$  | $$| $$$$$ /$$$$$$| $$ $$/$$ $$  | $$  | $$ $$ $$| $$$$$   '
echo '   | $$     | $$  | $$____/  \____  $$|______/| $$  | $$| $$__/|______/| $$  $$$| $$  | $$  | $$  $$$$| $$__/   '
echo '   | $$     | $$  | $$       /$$  \ $$        | $$  | $$| $$           | $$\  $ | $$  | $$  | $$\  $$$| $$      '
echo '   | $$    /$$$$$$| $$      |  $$$$$$/        |  $$$$$$/| $$           | $$ \/  | $$ /$$$$$$| $$ \  $$| $$$$$$$$'
echo '   |__/   |______/|__/       \______/          \______/ |__/           |__/     |__/|______/|__/  \__/|________/'
echo '.'                                                                                                                
           

echo '.'   
echo '**********************'
echo '* INSTALLATION: VM OK'
echo '**********************'
echo '.'

echo '.'
echo '**********************'
echo '* INSTALLATION: Debut MAJ'
echo '**********************'
echo '.'

yum install epel-release -y 

yum upgrade -y

yum upgrade -y

echo '.'
echo '**********************'
echo '* INSTALLATION: Fin MAJ'
echo '**********************'
echo '.'

echo '.'
echo '**********************'
echo '* INSTALLATION: Debut ENV'
echo '**********************'
echo '.'

echo ' - Desactivation SELINUX'

setenforce 0
sed -i --follow-symlinks "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/sysconfig/selinux

echo ' - Parametrage'

echo LANG=fr_FR.utf-8 >> /etc/environment
echo LC_ALL=fr_FR.utf-8 >> /etc/environment

echo ' - Timezone'

sudo timedatectl set-timezone Europe/Paris

echo '.'
echo '**********************'
echo '* INSTALLATION: Fin ENV'
echo '**********************'
echo '.'

echo '.'
echo '**********************'
echo '* INSTALLATION: Debut AdminTools'
echo '**********************'
echo '.'
echo ' - Installation composants'

yum install htop yum-utils nano mlocate -y

echo ' - Installation Supervision'

yum install python36-pip net-snmp yum-utils -y
yum install nrpe nagios-plugins-* --skip-broken -y

echo ' - Configuration Supervision'

echo ' -- Modification du fichier : nrpe.cfg'

sed -i --follow-symlinks "s/allowed_hosts=127.0.0.1,::1/allowed_hosts=127.0.0.1,::1,192.168.1.71,centreon,centreon.tips-of-mine.lan/g" /etc/nagios/nrpe.cfg

echo ' -- Creation du fichier : centreon.cfg'

sudo mv /Vagrantfiles/centreon.cfg /etc/nrpe.d/centreon.cfg

echo ' -- Sauvegarde du fichier : snmpd.conf'

mv /etc/snmp/snmpd.conf /etc/snmp/snmpd.conf.bak

echo ' -- Creation du fichier : snmpd.conf'

sudo mv /Vagrantfiles/snmpd.conf /etc/snmp/snmpd.conf

echo ' -- Creation du fichier : snmpd.conf'

echo ' - daemon Service'

systemctl daemon-reload

echo ' - Demarrage des services'

systemctl enable snmpd && systemctl start snmpd
systemctl enable nrpe && systemctl start nrpe

echo ' - Installation Inventaire'

yum install fusioninventory-agent fusioninventory-agent-task-inventory -y

echo ' - Configuration Inventaire'

echo ' -- Creation du fichier : agent.cfg'

sudo mv /Vagrantfiles/agent.cfg /etc/fusioninventory/agent.cfg

echo ' - daemon Service'

systemctl daemon-reload

echo ' - Demarrage des services'

systemctl restart fusioninventory-agent && systemctl enable fusioninventory-agent

echo ' - Configuration SSH'

sed -i --follow-symlinks "s/#HostKey/HostKey/g" /etc/ssh/sshd_config
sed -i --follow-symlinks "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sed -i --follow-symlinks "s/UseDNS no/#UseDNS yes/g" /etc/ssh/sshd_config

echo '.'
echo '**********************'
echo '* INSTALLATION: Fin AdminTools'
echo '**********************'
echo '.'

echo '.'
echo '**********************'
echo '* INSTALLATION: Debut Gestion Disque'
echo '**********************'
echo '.'
echo ' - Configuration disque'
sudo fdisk -u /dev/sda<<EOF
p
d
2
n
p
2


t
2
8e
w
EOF

echo ' - Configuration disque LVM'

echo '===================================================================================================='
sudo partx -u /dev/sda
echo '===================================================================================================='
sudo pvresize /dev/sda2
echo '===================================================================================================='
sudo pvscan
echo '===================================================================================================='
sudo vgdisplay
echo '===================================================================================================='
sudo lvdisplay
echo '===================================================================================================='
sudo lvextend -l +100%FREE -r /dev/centos_centos7/root
echo '===================================================================================================='

echo '.'
echo '**********************'
echo '* INSTALLATION: Fin Gestion Disque'
echo '**********************'
echo '.'

echo '.'
echo '**********************'
echo '* INSTALLATION: Reboot'
echo '**********************'
echo '.'