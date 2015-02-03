#!/bin/bash

# 
# we are adding 3 more servers.
# haproxy will bind them after few secs.
#
# access to haproxy stats panel:
#   http://<ip>:9999/
# 
# access to web content:
#   http://<ip>:3000/
#

function main() {
  start_webserver
  start_webserver
  start_webserver
};


function start_webserver() {
  docker run -d --link serf:serf webserver
};

main