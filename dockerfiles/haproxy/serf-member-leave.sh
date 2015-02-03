#!/bin/bash

while read line; do
  CONTAINER_NAME=$(echo $line | awk '{ print $1 }')
  sed -i'' "/ ${CONTAINER_NAME}/d" /etc/haproxy/haproxy.cfg
done

supervisorctl restart haproxy:*