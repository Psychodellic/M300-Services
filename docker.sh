#!/bin/bash

docker run --name osticket_mysql -d -e MYSQL_ROOT_PASSWORD=secret -e MYSQL_USER=osticket -e MYSQL_PASSWORD=secret -e MYSQL_DATABASE=osticket mysql:5

echo "MySQL VM erstellt"

docker run --name osticket -d --link osticket_mysql:mysql -p 8080:80 campbellsoftwaresolutions/osticket

echo "OSTicket VM erstellt"
echo "dockerstart.sh zum VM starten"
echo "dockerstop.sh zum VM stoppen"
