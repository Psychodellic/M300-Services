#!/bin/bash

docker stop osticket_mysql

echo "MySQL VM gestoppt"

docker stop osticket

echo "OSTicket VM gestoppt"
