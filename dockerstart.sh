#!/bin/bash

docker start osticket_mysql

echo "Mysql VM gestartet"

docker start osticket

echo "OSticket VM gestartet"
