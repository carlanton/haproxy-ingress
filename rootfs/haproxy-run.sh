#!/bin/sh

export MULTIBINDER_SOCK=/run/multibinder.sock
CONFIG=/usr/local/etc/haproxy/haproxy.cfg.erb
haproxy=$(which haproxy)

# Start multibinder
multibinder ${MULTIBINDER_SOCK} &
multibinder_pid=$!

# Wait for socket
while [ ! -f ${MULTIBINDER_SOCK} ]; do
  sleep 1;
done

# Create initial config
multibinder-haproxy-erb ${haproxy} -f ${CONFIG} -c -q

# Start haproxy
multibinder-haproxy-wrapper ${haproxy} -Ds -f ${CONFIG} -p /var/run/haproxy.pid &
wrapper_pid=$!

echo $wrapper_pid > /var/run/wrapper.pid

/haproxy-ingress-controller
