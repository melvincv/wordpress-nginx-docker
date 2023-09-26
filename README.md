# 3 tier Wordpress with NGINX and Docker

## Objective

Run a 3 tier Wordpress site on a **single instance** using Docker Compose. Static file caching should be enabled on the client side. \
Use a container for each tier:

1. nginx
2. wordpress-fpm
3. mysql

Expose only ports 80 and 443. \
Also implement SSL using certbot and Let's Encrypt.

## Let's Encrypt SSL

Get a free SSL certificate using Let's Encrypt. This is implemented at the instance level and is done using the `certbot certonly` command.

> [!IMPORTANT]
> Ensure that your domain name is pointing to your instance before getting certificates.
> Get the certificate first and then run docker compose, as NGINX will require certificates to start and run. Else the nginx container will keep restarting.

- Update the variables and run the `install-certificate.sh` script.

```shell
# Domains to generate the certificate for, comma separated list
# Eg: domain1,domain2
DOMAINS=your.domain
# email id for certificate renewal
EMAILID=your.email
# Staging CA for testing?
STAGING=1
```

```shell
sudo bash install-certificate.sh
```

Follow the prompts. You should now get a staging SSL certificate. Next, run docker compose.

## Docker Compose

- Replace the domain name in the NGINX config using [this script](nginx/replace-domain.sh)

Use the normal docker compose commands to bring up the stack. Being Docker, this is a highly portable solution, though not scalable. \

> Note that you need to rename `env.sh` to `.env`, edit the `.env` file and add your secret variables for docker compose to work properly. \

```
docker compose up -d --build
```

## Getting the real certificates

- stop the nginx service (this is for the temporary web server started by certbot, which is used to validate the domain)

`docker compose stop nginx`

- Update the variables and run the `install-certificate.sh` script.

```shell
# Staging CA for testing?
STAGING=0
```

```shell
sudo bash install-certificate.sh
```

- start the nginx service

`docker compose start nginx`

Now your site should be up and runnning with free SSL!

> You may run the same script to renew the certificates.

## NGINX Config

[Main Config file](nginx/nginx.conf) \
[Virtualhost for Wordpress](nginx/wp.conf)

Modifying the main config file is optional. I have enabled `gzip` compression here. Also added support for large file uploads. \
The Virtualhost file contains the `server{}` block for the wordpress site. This contains all the virtualhost settings plus static file caching and SSL. \

## Wordpress Image Buiding

[Dockerfile and custom.ini](wp)

The above folder contains the Dockerfile and the custom.ini file containing custom PHP settings. \
This is used for building a custom wordpress-fpm image with the PHP settings that we want.

## Wordpress CLI

The WP CLI can be used to manage Wordpress even if the web interface is down. Modify the variables and run the script:

[Script](wpcli.sh)

## Security Headers

TODO
