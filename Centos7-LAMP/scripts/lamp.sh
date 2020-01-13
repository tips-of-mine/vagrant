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
echo '/$$            /$$$$$$      /$$      /$$     /$$$$$$$  '
echo '| $$           /$$__  $$    | $$$    /$$$    | $$__  $$'
echo '| $$          | $$  \ $$    | $$$$  /$$$$    | $$  \ $$'
echo '| $$          | $$$$$$$$    | $$ $$/$$ $$    | $$$$$$$/'
echo '| $$          | $$__  $$    | $$  $$$| $$    | $$____/ '
echo '| $$          | $$  | $$    | $$\  $ | $$    | $$      '
echo '| $$$$$$$$ /$$| $$  | $$ /$$| $$ \/  | $$ /$$| $$ /$$  '
echo '|________/|__/|__/  |__/|__/|__/     |__/|__/|__/|__/  '
echo '.'

echo '.'     
echo '**********************'
echo '* INSTALLATION: Debut HTTPD'
echo '**********************'
echo '.'
echo ' - Installation'

yum install httpd -y

echo ' - Configuration service'

systemctl enable httpd
systemctl start httpd

echo '**********************'
echo '* INSTALLATION: Fin HTTPD'
echo '**********************'
echo '.'

echo '.'
echo '**********************'
echo '* INSTALLATION: Debut MySQL'
echo '**********************'
echo '.'
echo ' - Installation'

sudo mv /Vagrantfiles/mariadb.repo /etc/yum.repos.d/mariadb.repo

yum install mariadb-server MariaDB-backup mariadb -y

echo ' - Configuration'

sudo passwd root<<EOF
P@ssw0rds
P@ssw0rds
EOF

sudo systemctl start mariadb<<EOF
P@ssw0rds
EOF

sudo /usr/bin/mysqladmin -u root password 'P@ssw0rds'

sudo mysql_secure_installation<<EOF
P@ssw0rds
n
y
n
y
y
EOF

echo ' - Configuration service'

systemctl enable mariadb
systemctl start mariadb

echo '.'
echo '**********************'
echo '* INSTALLATION: Fin MySQL'
echo '**********************'
echo '.'

echo '.'
echo '**********************'
echo '* INSTALLATION: Debut PHP'
echo '**********************'
echo '.'
echo ' - Installation'

rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm

yum-config-manager --enable remi-php71

yum install php -y
yum install php-mysql php-fpm php-opcache php-mysqlnd php-pdo php-gd php-ldap php-odbc php-pear php-xml -y
yum install php-xmlrpc php-opcache php-mbstring php-soap curl curl-devel php-pear-CAS php-imap php-apcu -y

echo '.'
echo '**********************'
echo '* INSTALLATION: Fin PHP'
echo '**********************'
echo '.'

echo '.'
echo '**********************'
echo '* INSTALLATION: Debut PHPMyAdmin'
echo '**********************'
echo '.'
echo ' - Installation'

yum -y install phpMyAdmin -y

echo ' - Configuration'

echo ' -- Creation du fichier : phpMyAdmin.conf'

sudo mv /Vagrantfiles/phpMyAdmin.conf /etc/httpd/conf.d/phpMyAdmin.conf

echo '.'
echo '**********************'
echo '* INSTALLATION: Fin PHPMyAdmin'
echo '**********************'
echo '.'

cd /var/www/html/

sudo tee info.php <<-EOF
<?php
phpinfo();
?>
EOF

echo ' - Restart service HTTPD'

systemctl restart httpd

echo '.'
echo '**********************'
echo '* INSTALLATION: Debut Firewall'
echo '**********************'
echo '.'

firewall-cmd --permanent --zone=public --add-service=http 
firewall-cmd --permanent --zone=public --add-service=https
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


Bienvenue dans la version Centos 7 Linux.Apache.MySQL.PHP

 - Apache 2.4, MySQL Mariadb 8 and PHP 7.1


To test your environment is correctly working, just open following URL from your Host OS:
http://localhost/info.php

EOF
