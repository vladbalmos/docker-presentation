FROM ubuntu-apache
MAINTAINER Vlad Balmos <vlad.balmos@code932.com>
RUN apt-get update && \
    apt-get install libapache2-mod-php5 \ 
    php5-gd php5-curl php5-mysqlnd \
    php5-mcrypt php5-apcu -y

# Create a user that will have the same uid & gid as the host user
RUN groupadd -r -g 1000 my-apache-user
RUN useradd -r -g my-apache-user -u 1000 -M my-apache-user

# Enable apache mod_rewrite and mod_headers
RUN a2enmod rewrite headers
RUN sed -i s/www-data/my-apache-user/g /etc/apache2/envvars
VOLUME ["/etc/apache2/sites-enabled", "/srv/wordpress"]
EXPOSE 80
COPY start-apache.sh /usr/local/bin/start-apache.sh
CMD /usr/local/bin/start-apache.sh
