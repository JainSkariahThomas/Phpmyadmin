#!/bin/bash

sudo apt update -y
sudo apt install apache2 wget unzip -y
sudo apt install mysql-server -y
sudo apt install php php-zip php-json php-mbstring php-mysql -y
sudo systemctl enable mysql
sudo systemctl start mysql
sudo systemctl enable apache2
sudo systemctl start apache2
sudo wget https://files.phpmyadmin.net/phpMyAdmin/5.0.3/phpMyAdmin-5.0.3-all-languages.zip
sudo unzip phpMyAdmin-5.0.3-all-languages.zip
sudo mv phpMyAdmin-5.0.3-all-languages /usr/share/phpmyadmin
sudo mkdir /usr/share/phpmyadmin/tmp
sudo chown -R www-data:www-data /usr/share/phpmyadmin
sudo chmod 777 /usr/share/phpmyadmin/tmp
sudo cat << EOF >> /etc/apache2/conf-available/phpmyadmin.conf
Alias /phpmyadmin /usr/share/phpmyadmin
Alias /phpMyAdmin /usr/share/phpmyadmin
 
<Directory /usr/share/phpmyadmin/>
   AddDefaultCharset UTF-8
   <IfModule mod_authz_core.c>
      <RequireAny>
      Require all granted
     </RequireAny>
   </IfModule>
</Directory>
 
<Directory /usr/share/phpmyadmin/setup/>
   <IfModule mod_authz_core.c>
     <RequireAny>
       Require all granted
     </RequireAny>
   </IfModule>
</Directory>
EOF

sudo a2enconf phpmyadmin
sudo systemctl restart apache2
