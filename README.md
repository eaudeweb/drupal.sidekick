# Drupal SideKick

`Your Drupal development buddy`(tm)

## Setup

1. Install Docker

Follow-up on the official documentaiton how to get the latest Docker version for your platform - https://docs.docker.com/get-docker/

2. Clone this repository locally

Clone this repository somewhere on your computer, preferably on: `/opt/host.containers`

```bash
sudo mkdir /opt/host.containers
sudo chown <USER>:<USER> /opt/host.containers
git clone https://github.com/eaudeweb/host.containers /opt/host.containers
sudo chown -R 8983:8983 /opt/host.containers/data/solr
```

3. Customize services

You can copy `example.override.yml` to `override.yml` and customize it to your needs. Keep in mind that you can fully override: `volumes` and other aspects of service definition (either through `override.yml` OR `.env` file) Read more [here](https://docs.docker.com/compose/compose-file/03-compose-file/) and [here](https://docs.docker.com/compose/compose-file/13-merge/).

4. Start the services

Example commands:

1. Start the default services: `sudo ./service.sh up`
1. Start the default services without blocking the console: `sudo ./service.sh up -d`
1. Start Solr services: `sudo ./service.sh --profile solr up`
1. Stop services: `sudo ./service.sh --profile solr stop` (use the same profile to close all services)

## Services

Enabling and disabling services: By default there is only a single service enabled: `MailHog`. In the sections below, each service is described in detail. If you want to use a certain service you can use profiles. The following profiles are defined:

- `solr` - Start Apache Solr servers
- `mariadb` - Start MariaDB servers
- `tomcat` - Start Tomcat servlet container
- `varnish` - Start Varnish containers 

### MailHog

**Description**: The MailHog service creates a SMTP local server to send emails and receive emails. It does not send real emails and therefore if it runs locally on port `25` - it avoids sending real emails when doing local mailing tests. All emails sent can be seen in an Webmail UI available at http://localhost:8025.

**Warning**: Make sure you stop your sendmail if you decide to run it on port `25`:

```bash
systemctl stop sendmail
systemctl disable sendmail
systemctl stop postfix
systemctl disable postfix
```

**Configuration**:

- You can change the default listening ports locally by adding environment variables in an `.env` file in this folder.

Example:

```
MAILHOG_SMTP_PORT=1025
MAILHOG_HTTP_PORT=8000
```


### Apache Solr

These services are listening on local TCP/IP ports `8983` and `8984`. Make sure there is no conflict with other services. Below are instructions how to manage Solr cores.

#### To create a new Solr core

See below commands to create a new core. Replace `NEWCORENAME` with the actual name

```bash
sudo su -
cd /opt/host.containers/data/solr/7/cores/
mkdir -p NEWCORENAME/conf
cd /opt/host.containers/data/solr/7/cores/NEWCORENAME/conf/
touch /opt/host.containers/data/solr/7/cores/NEWCORENAME/core.properties
# Download and copy Drupal core template from http://drupal.localhost/admin/config/search/search-api/server/solr/solr_configset/config-zip (solr_x.y_config.zip) to conf/
cp ~/Desktop/solr_7.x_config.zip .
unzip solr_7.x_config.zip
sudo chown -R 8983:8983 /opt/host.containers/data/solr/7/cores/NEWCORENAME
docker compose restart solr7
```

## FAQ

### 2. How to see docker logs

You can look for errors while contaiers are starting.

```bash
docker logs --tail=100 --follow solr7
```
