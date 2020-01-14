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
echo ' /$$$$$$$  /$$$$$$$   /$$$$$$   /$$$$$$  /$$$$$$$$  /$$$$$$   /$$$$$$'
echo '| $$__  $$| $$__  $$ /$$__  $$ /$$__  $$| $$_____/ /$$__  $$ /$$__  $$'
echo '| $$  \ $$| $$  \ $$| $$  \ $$| $$  \__/| $$      | $$  \__/| $$  \__/'
echo '| $$$$$$$/| $$$$$$$/| $$  | $$| $$      | $$$$$   |  $$$$$$ |  $$$$$$'
echo '| $$____/ | $$__  $$| $$  | $$| $$      | $$__/    \____  $$ \____  $$'
echo '| $$      | $$  \ $$| $$  | $$| $$    $$| $$       /$$  \ $$ /$$  \ $$'
echo '| $$      | $$  | $$|  $$$$$$/|  $$$$$$/| $$$$$$$$|  $$$$$$/|  $$$$$$/'
echo '|__/      |__/  |__/ \______/  \______/ |________/ \______/  \______/'
echo ' '
echo '       /$$      /$$  /$$$$$$  /$$   /$$ /$$$$$$$$ /$$$$$$$'
echo '      | $$$    /$$$ /$$__  $$| $$  /$$/| $$_____/| $$__  $$'
echo '      | $$$$  /$$$$| $$  \ $$| $$ /$$/ | $$      | $$  \ $$'
echo '      | $$ $$/$$ $$| $$$$$$$$| $$$$$/  | $$$$$   | $$$$$$$/'
echo '      | $$  $$$| $$| $$__  $$| $$  $$  | $$__/   | $$__  $$'
echo '      | $$\  $ | $$| $$  | $$| $$\  $$ | $$      | $$  \ $$'
echo '      | $$ \/  | $$| $$  | $$| $$ \  $$| $$$$$$$$| $$  | $$'
echo '      |__/     |__/|__/  |__/|__/  \__/|________/|__/  |__/'
echo '.'

echo '.'     
echo '**********************'
echo '* INSTALLATION: Debut HTTPD'
echo '**********************'
echo '.'
echo ' - Installation'

sudo yum install httpd mod_ssl -y

sudo sed -i 's@#LoadModule expires_module modules/mod_expires.so@LoadModule expires_module modules/mod_expires.so@' /etc/httpd/conf/httpd.conf ;
sudo sed -i 's@#LoadModule rewrite_module modules/mod_rewrite.so@LoadModule rewrite_module modules/mod_rewrite.so@' /etc/httpd/conf/httpd.conf ;
sudo sed -i 's@#LoadModule deflate_module modules/mod_deflate.so@LoadModule deflate_module modules/mod_deflate.so@' /etc/httpd/conf/httpd.conf ;
sudo sed -i 's@#LoadModule vhost_alias_module modules/mod_vhost_alias.so@LoadModule vhost_alias_module modules/mod_vhost_alias.so@' /etc/httpd/conf/httpd.conf ;
sudo sed -i 's@#LoadModule filter_module modules/mod_filter.so@LoadModule filter_module modules/mod_filter.so@' /etc/httpd/conf/httpd.conf ;

echo ' - Configuration service'

sudo systemctl enable httpd && sudo systemctl start httpd

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

sudo yum install mariadb-server MariaDB-backup mariadb -y

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

sudo tee /etc/my.cnf.d/pmaker.cnf <<-EOF
optimizer_switch = derived_merge=off
sql_mode= ""
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
yum install php-xmlrpc php-cli php-mbstring php-soap curl curl-devel php-pear-CAS php-imap php-apcu php-pecl-apcu php-mcrypt -y 

echo '============================================================'
sudo php -m
echo '============================================================'

sudo sed -i '/short_open_tag = Off/c\short_open_tag = On' /etc/php.ini
sudo sed -i '/post_max_size = 8M/c\post_max_size = 24M' /etc/php.ini
sudo sed -i '/upload_max_filesize = 2M/c\upload_max_filesize = 24M' /etc/php.ini
sudo sed -i '/;date.timezone =/c\date.timezone = Europe/Paris' /etc/php.ini
sudo sed -i '/expose_php = On/c\expose_php = Off' /etc/php.ini

sudo systemctl start php-fpm.service && sudo systemctl enable php-fpm.service

sudo mv /Vagrantfiles/processmaker.conf /etc/php-fpm.d/processmaker.conf

sudo sed -i '/;opcache.enable_cli=0/c\opcache.enable_cli=1' /etc/php.d/opcache.ini
sudo sed -i '/opcache.max_accelerated_files=4000/c\opcache.max_accelerated_files=10000' /etc/php.d/opcache.ini
sudo sed -i '/;opcache.max_wasted_percentage=5/c\opcache.max_wasted_percentage=5' /etc/php.d/opcache.ini
sudo sed -i '/;opcache.use_cwd=1/c\opcache.use_cwd=1' /etc/php.d/opcache.ini
sudo sed -i '/;opcache.validate_timestamps=1/c\opcache.validate_timestamps=1' /etc/php.d/opcache.ini
sudo sed -i '/;opcache.fast_shutdown=0/c\opcache.fast_shutdown=1' /etc/php.d/opcache.ini

sudo mv /Vagrantfiles/pmos.conf /etc/httpd/conf.d/pmos.conf

echo '.'
echo '**********************'
echo '* INSTALLATION: Fin PHP'
echo '**********************'
echo '.'

echo '.'
echo '**********************'
echo '* INSTALLATION: Debut Supervisor'
echo '**********************'
echo '.'
echo ' - Installation'

sudo yum install supervisor -y

sudo systemctl start supervisord && sudo systemctl enable supervisord

sudo mv /Vagrantfiles/laravel-worker-workflow.ini /etc/supervisord.d/laravel-worker-workflow.ini

sudo supervisorctl reread
sudo supervisorctl update

sudo supervisorctl stop all
sudo supervisorctl start all
sudo systemctl stop supervisord.service && sudo systemctl start supervisord.service

echo '.'
echo '**********************'
echo '* INSTALLATION: Fin Supervisor'
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

echo '.'
echo '**********************'
echo '* INSTALLATION: Debut ProcessMaker'
echo '**********************'
echo '.'

sudo mkdir -p /opt/processmaker && cd /opt/processmaker

sudo wget https://github.com/ProcessMaker/processmaker/releases/download/4.0rc1/processmaker4.0-rc1.tar.gz

sudo tar zxvf processmaker4.0-rc1.tar.gz 

sudo chown -R apache:apache /opt/processmaker

echo '.'
echo '**********************'
echo '* INSTALLATION: Fin ProcessMaker'
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
