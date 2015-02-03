#!/bin/bash

#
# simulation of some crash of haproxy.
# due to supervisor, haproxy will be up in few secs after.
#
# access to haproxy stats panel:
#   http://<ip>:9999/
#

function main() {
  kill_haproxy_in_its_container
};


function kill_haproxy_in_its_container() {
  docker exec $(haproxy_container) kill $(haproxy_pid_in_its_container)
};

function haproxy_pid_in_its_container() {
  docker exec $(haproxy_container) pgrep haproxy
};

function haproxy_container() {
  docker ps | grep haproxy | cut -c 1-16
};

main