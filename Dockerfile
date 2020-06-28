FROM debian:8.11
EXPOSE 80
RUN apt-get update && apt-get install -y apache2 curl mysql-client php5 libapache2-mod-php5 php5-mysql
COPY php.ini /etc/php5/cli
RUN mkdir /var/www/html/public
RUN mkdir /var/log/custom
COPY vhost.conf /etc/apache2/sites-available/
RUN a2ensite vhost && a2dissite 000-default
RUN a2enmod rewrite

WORKDIR /var/www/html

RUN usermod -u 1000 www-data
RUN chown -R www-data:www-data /var/www/html/public
RUN chown -R www-data:www-data /var/www/html/public
RUN chown -R www-data:www-data /var/log/custom

CMD /usr/sbin/apache2ctl -D FOREGROUND