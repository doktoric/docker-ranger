#!/bin/bash
set -xe

cd /opt/ranger_home/

mysql -h db -uroot -ppassword < /opt/ranger_home/ranger.sql

./setup.sh

ranger-admin start

# Stream the logs to standout
tail -f logfile