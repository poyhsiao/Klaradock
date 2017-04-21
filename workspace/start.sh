#!/bin/sh

# check is supervisord is exists
if type "supervisord" > /dev/null; then
  $(which supervisord) -c /etc/supervisor/supervisord.conf -n
fi
