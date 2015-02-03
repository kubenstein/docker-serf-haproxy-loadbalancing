#!/bin/bash

#
# run haproxy in foreground because supervisor will manage processes.
# -sf sends finish signal to previous haproxy proccess so it can finish serving stuff and then shutdown
# it can shut down because new haproxy with new configuration is already up

/usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg -sf `pgrep haproxy`