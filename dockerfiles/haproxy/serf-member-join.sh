#!/bin/bash

while read line; do
  SHOULD_RELOAD=0
  SERF_ROLE=`echo $line | awk '{ print $3 }'`
    if [ "_${SERF_ROLE}" != "_web" ]; then
      continue
    fi

  echo $line | awk '{ printf "\n    server %s %s:8000 check", $1, $2 }' >> /etc/haproxy/haproxy.cfg
  SHOULD_RELOAD=1
done


if [ "_${SHOULD_RELOAD}" == "_1" ]; then
  supervisorctl restart haproxy:*
fi