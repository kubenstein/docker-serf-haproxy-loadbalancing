#!/bin/bash

exec serf agent \
    -tag role=lb \
    -join $SERF_PORT_7946_TCP_ADDR:$SERF_PORT_7946_TCP_PORT \
    -event-handler="member-join=/serf-member-join.sh" \
    -event-handler="member-leave,member-failed=/serf-member-leave.sh"
