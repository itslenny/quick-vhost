quick-vhost
===========

A simple bash script to quickly create a virtual host config file for Apache and Nginx. Also, creates the main document root and a static document root (public sub directory) served by Nginx directly.

This script was created for a very specific purpose, but could probably be easily configured for other purposes. The setup it's meant for is a host computer running multiple websites on using Apache running inside of a docker container and using Nginx to route requests. It also automatically creates a static subdomain that can be used for bypassing Apache for static content.

**SETUP**
Simply edit the configuration directories at the top of the main .sh file and customize the templates in the template directory as needed.

**EXAMPLE USAGE**
```
./quick-vhost.sh itslennysfault.com
Creating apache vhost conf
Creating apache nginx conf
Creating apache document root
Creating static document root
Creating placeholder indexes
```

This would create the following files / directories in the default configuration:

* /var/www/vhosts/itslennysfault.com.conf 
  * Apache config file for the virtual host itslennysfault.com pointing to the document root of the same name
* /etc/nginx/sites-enabled/itslennysfault.com
  * Nginx config file for the virtual host itslennysfault.com that proxies to apache running inside of a docker container AND static.itslennysfault.com pointing to the public sub folder of that same document root allowing nginx to serve static files from that subdomain
* /etc/httpd/vhosts/itslennysfault.com
  * Apache document root
* /etc/httpd/vhosts/itslennysfault.com/public
  * Nginx static document root
* also creates a placeholder index.html in both of the document roots.