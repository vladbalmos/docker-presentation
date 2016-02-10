# Variables
WORDPRESS_DIR = $(shell readlink -f ./devel/wordpress-4.3)
APACHE_CONFIG_DIR = $(shell readlink -f ./devel/apache-config)
.DEFAULT_GOAL := run-apache-background

# Images
ubuntu-apache-image:
	docker build -t ubuntu-apache images/apache2
wordpress-apache-image: ubuntu-apache-image
	docker build -t wordpress-apache images/wordpress
wordpress-mysql-image:
	docker build -t wordpress-mysql images/mysql

# Containers
#
# Mysql
create-mysql-container: wordpress-mysql-image
	docker ps -a | grep wp-mysql || \
	docker create --name=wp-mysql \
				  --restart=always \
				  -p 23306:3306 \
				  wordpress-mysql

run-mysql-foreground: create-mysql-container
	docker start -a -i wp-mysql

run-mysql-background: create-mysql-container
	docker start wp-mysql

# Apache
create-apache-container: wordpress-apache-image create-mysql-container
	docker ps -a | grep wp-apache || \
	docker create --name=wp-apache \
				  --restart=always \
				  -p 28080:80 \
				  -v $(WORDPRESS_DIR):/srv/wordpress \
				  -v $(APACHE_CONFIG_DIR):/etc/apache2/sites-enabled \
				  --link wp-mysql:db-host \
				  wordpress-apache

run-apache-foreground: create-apache-container run-mysql-background
	docker start -a -i wp-apache
run-apache-background: create-apache-container run-mysql-background
	docker start wp-apache

install:
	./setup.sh

docker-clean:
	docker rm -f wp-apache wp-mysql || true
	docker rmi -f wordpress-apache wordpress-mysql ubuntu-apache || true

clean: docker-clean
	rm -rf devel/wordpress-4.3
	rm -rf ~/tmp/docker-presentation/host-volume
