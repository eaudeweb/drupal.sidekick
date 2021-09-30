# Services for developer workstation


## 1. Install Docker

Documentation - https://docs.docker.com/get-docker/

```bash
sudo apt install docker.io docker-compose
sudo systemctl enable docker
sudo systemctl start docker
```

## 2. Install `Docker compose` tool

Info: https://docs.docker.com/compose/install/ (on Ubuntu/Mint I recommend to install in `/usr/bin/docker-compose` instead of `/usr/local/bin/docker-compose` which is not in `$PATH`)

Example:

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
```


## 3. Clone this repository locally


You will need to clone this repository in `/opt/host.containers`


```bash
sudo mkdir /opt/host.containers
sudo chown <cristiroma>:<cristiroma> /opt/host.containers
git clone git@gitlab.edw.ro:drupal/devel.host.services.git /opt/host.containers
sudo chown -R 8983:8983 /opt/host.containers/solr
sudo docker-compose up
```


## 4. Enable or disable services


To keep things simple, you can enable or disable services by directly editing the `docker-compose.yml` and commeting/un-commenting services.

**Note:** Editing this file is not ideal, but currently cannot disable services from `docker-compose.override.yml`. There is support for profiles in the near future: https://docs.docker.com/compose/profiles/ which means you don't need to edit the file, but use the override file to customize the existing services.


## FAQ

### 1. How to create a new Solr core

See below commands to create a new core. Replace `NEWCORENAME` with the actual name

```bash
sudo su -
cd /opt/host.containers/solr/7/cores/
mkdir -p NEWCORENAME/conf
cd /opt/host.containers/solr/7/cores/NEWCORENAME/conf/
touch /opt/host.containers/solr/7/cores/NEWCORENAME/core.properties
# Download and copy Drupal core template from http://glad9.test/admin/config/search/search-api/server/solr/solr_configset/config-zip (solr_x.y_config.zip) to conf/
cp ~/Desktop/solr_7.x_config.zip .
unzip solr_7.x_config.zip
sudo chown -R 8983:8983 /opt/host.containers/solr/7/cores/NEWCORENAME
docker-compose restart solr7
```

### 2. How to see docker logs

You can look for errors while contaiers are starting.

```bash
docker logs --tail=100 --follow solr7
```

