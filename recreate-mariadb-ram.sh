#!/usr/bin/env bash

docker compose stop mariadb_ram
docker compose rm -f mariadb_ram
./start.sh -d
