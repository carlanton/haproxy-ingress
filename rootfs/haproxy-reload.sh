#!/bin/sh
/usr/local/bin/multibinder-haproxy-erb /usr/local/sbin/haproxy \
    -c -f /usr/local/etc/haproxy/haproxy.cfg.erb

/bin/kill -USR2 $(cat /var/run/wrapper.pid)
