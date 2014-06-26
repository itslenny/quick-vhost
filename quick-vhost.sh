#!/bin/bash

#BASIC CONFIG -- paths should end with a /

#location where virtual domain document roots should be stored
APACHE_DOCUMENT_DIR="/var/www/vhosts/"
#apache config directory include from base httpd / apache conf
APACHE_VHOST_DIR="/etc/httpd/vhosts/"
#ninx vhost config directory
NGINX_VHOST_DIR="/etc/nginx/sites-enabled/"

#directory of this script
SCRIPT_DIR=`dirname "$BASH_SOURCE"`
#absolute path to template directory
TEMPLATE_DIR="$SCRIPT_DIR/templates/"

#check the config directories
[ ! -d $APACHE_VHOST_DIR ] && echo "APACHE_VHOST_DIR not found. Check Configuration" && exit -1
[ ! -d $APACHE_DOCUMENT_DIR ] && echo "APACHE_DOCUMENT_DIR not found. Check Configuration" && exit -1
[ ! -d $NGINX_VHOST_DIR ] && echo "NGINX_VHOST_DIR not found. Check Configuration" && exit -1


#Check if either of the vhost configs have already been created
if [ -f "$APACHE_VHOST_DIR$1.conf" ] || [ -f "$NGINX_VHOST_DIR$1" ]
    then
        echo "ERROR: the vhost files already exists"
        exit -1
    else
        #create apache conf
        echo "Creating apache vhost conf"
        sed -e "s;%VHOST%;$1;g" -e "s;%DOCROOT%;$APACHE_DOCUMENT_DIR$1;g" "${TEMPLATE_DIR}apache_template.conf" > "$APACHE_VHOST_DIR$1.conf"
        #create nginx conf
        echo "Creating apache nginx conf"
        sed -e "s;%VHOST%;$1;g" -e "s;%DOCROOT%;$APACHE_DOCUMENT_DIR$1;g" "${TEMPLATE_DIR}nginx_template.conf" > "$NGINX_VHOST_DIR$1"
        
        #check for the document root
        if [ -d "$APACHE_DOCUMENT_DIR$1" ]
            then
                echo "ERROR: Apache document root already exists"
            else
                echo "Creating apache document root"
                mkdir "$APACHE_DOCUMENT_DIR$1"
                echo "Creating static document root"
                mkdir "$APACHE_DOCUMENT_DIR$1/public"
                echo "Creating placeholder indexes"
                cp "${TEMPLATE_DIR}index.html" "$APACHE_DOCUMENT_DIR$1"
                cp "${TEMPLATE_DIR}index.html" "$APACHE_DOCUMENT_DIR$1/public"                
        fi
fi