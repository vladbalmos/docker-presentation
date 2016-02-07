#!/bin/bash

. /etc/apache2/envvars 
rm -f /var/run/apache2/apache2*.pid
/usr/sbin/apache2 -DFOREGROUND
