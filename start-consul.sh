#!/bin/sh
consul agent -server -bootstrap-expect=1 \
    -data-dir=/tmp/consul -node=agent-one -bind=<tsung_master_ip> \
    -config-dir=/etc/consul.d
