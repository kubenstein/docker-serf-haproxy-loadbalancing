#!/bin/bash

# 
# we are adding 3 more servers, which will be binded to haproxy in a few secs.
# and then we stop all previously running servers.
#
# access to haproxy stats panel:
#   http://<ip>:9999/
# 
# access to web content:
#   http://<ip>:3000/
#

function main() {
  WEBSERVER_CONTAINER_IDS=$(running_servers)
  start_webserver
  start_webserver
  start_webserver
  stop_webservers $WEBSERVER_CONTAINER_IDS
};


function start_webserver() {
  docker run -d --link serf:serf webserver
};

function running_servers() {
  docker ps | grep webserver | cut -c 1-16
};

function stop_webservers() {
  docker stop $@
};

main