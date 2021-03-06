#!/bin/bash
set -e -o pipefail

echo "### STARTING APACHE"
systemctl start apache2

echo "### STARTING SITE"
omd start "$cmk_site_name"

echo "### STARTING GRAFANA"
systemctl start grafana-server

echo "### STARTING NAGFLUX"
systemctl start nagflux

echo "### Starting Thruk"
systemctl start thruk

#echo "### STARTING CRON"
#cron -f &

#echo "### CONTAINER STARTED"
#wait
