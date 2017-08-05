#/bin/sh

source /opt/rh/rh-php56/enable
source /opt/rh/httpd24/enable

sed -i -e "s/^upload_max_filesize.*/upload_max_filesize=${MAX_UPLOAD}/g" /etc/opt/rh/rh-php56/php.ini
sed -i -e "s/^post_max_size.*/post_max_size=${MAX_UPLOAD}/g" /etc/opt/rh/rh-php56/php.ini

exec /opt/rh/httpd24/root/usr/sbin/httpd -DFOREGROUND
