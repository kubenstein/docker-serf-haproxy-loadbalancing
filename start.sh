#!/bin/bash

#
# whole configuration setup:
# - serf as a discovery service 
# - haproxy as a loadbalancer 
# - nginx with static content as a web server
# - second nginx starts after 10s 
#
# access to haproxy stats panel:
#   http://<ip>:9999/
# 
# access to web content:
#   http://<ip>:3000/
#
#
# to monitor servers membership run:
#   docker run -i -t --link serf:serf_1 ctlc/serf-members
#

function main() {
  start_serf_ambassador
  start_loadbalancer
  start_webserver

  sleep 10
  start_webserver
};


function start_serf_ambassador() {
  docker run -d --name serf -p 7373 -p 7946 ctlc/serf
};

function start_loadbalancer() {
  docker build -t haproxy-serf ./dockerfiles/haproxy/
  docker run -d --name loadbalancer -p 3000:80 -p 9999:9999 --link serf:serf haproxy-serf
};

function start_webserver() {
  docker build -t webserver ./dockerfiles/server/
  docker run -d --link serf:serf webserver
};

main