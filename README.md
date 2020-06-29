# M300-Services

* Erklärung vom Code
  * docker.sh
  * dockerstart.sh
  * dockerstop.sh
* Shell Script starten
* Shell Script anpassen
* Sicherheit
* Testing
  * Testfälle
  * Testergebnisse 
* Fazit
* Reflexion
* Wissensgewinn
---

## Erklärung vom Code

### docker.sh

Das Script erstellt einen Docker-Umgebung auf der eine Mysql Datenbank läuft.

Danach wird ein zweite Docker-Umgebung aufgebaut, auf der OSTicket läuft.

Beide Umgebungen werden nach der Erstellung gestartet


```
#!/bin/bash
```

* Mit dem Befehl `#!/bin/bash` wird dem System gesagt das die Umgebung mit der Bash aufegbaut werden soll. Das System weiss das es für dieses Shellscript die Bash verwenden muss. 

```
docker run --name osticket_mysql -d -e MYSQL_ROOT_PASSWORD=secret -e MYSQL_USER=osticket -e MYSQL_PASSWORD=secret -e MYSQL_DATABASE=osticket mysql:5
```

* Mit dieser Zeile wird ein Docker-Container erstellt mit dem Namen `osticket_mysql`. Dieser Docker-Container der erzeugt wird hat schon MySQL instaliert. Angaben wie Datenbank Passwort, MySQL User sowie Datenbank name werden angegeben.  

```
echo "MySQL VM erstellt"
```

* Dem User wird mitgeteilt das die MySQL aufgebaut wurde.

```
docker run --name osticket -d --link osticket_mysql:mysql -p 8080:80 campbellsoftwaresolutions/osticket
```

* Ladet den OSTicket Docker-Container von `campbellsoftwaresolutions` herunter und erstellt diesen Conatiner mit dem Namen `osticket`. Der Port 8080 wird auf den internen Port 80 umgeleitet. Es wird eine Verknüpfung der MySQL Datenbank mit der Docker-Umgebung `osticket_mysql` gemacht. Die `osticket` Umgebung benutzt die MySQL Datenbank der `osticket_mysql` Umgebung. 

---

### dockerstart.sh

Mit diesem Script können die beiden Erstellten Dockerumgebungen gestartet werden, falls diese mal gestoppt sind.

```
#!/bin/bash
```

* Mit dem Befehl `#!/bin/bash` wird dem System gesagt das die Umgebung mit der Bash aufegbaut werden soll. Das System weiss das es für dieses Shellscript die Bash verwenden muss. 

```
docker start osticket_mysql
```

* startet den Docker-Container mit dem Namen `osticket_mysql`.

```
echo "Mysql VM gestartet"
```

* Dem User wird mitgeteilt das der Docker-Container `osticket_mysql` gestartet wurde.

```
docker start osticket
```

* startet den Docker-Conatiner mit dem Namen `osticket`.

```
echo "OSticket VM gestartet"
```

* Dem User wird mitgeteilt das der Docker-Container `osticket` gestartet wurde.

---

### dockerstop.sh

Mit diesem Script können die beiden Dockerumgebungen gestoppt werden. 

```
#!/bin/bash
```

* Mit dem Befehl `#!/bin/bash` wird dem System gesagt das die Umgebung mit der Bash aufegbaut werden soll. Das System weiss das es für dieses Shellscript die Bash verwenden muss.

```
docker stop osticket_mysql
```

* stoppt den Docker-Container mit dem Namen `osticket_mysql`.

```
echo "MySQL VM gestoppt"
```

* Dem User wird mitgeteilt das der Docker-Container `osticket_mysql` gestoppt wurde.

```
docker stop osticket
```

* stoppt den Docker-Container mit dem Namen `osticket`.

```
echo "OSTicket VM gestoppt"
```

* Dem User wird mitgeteilt das der Docker-Container `osticket` gestoppt wurde.

---


## Shell Script starten

* Das Script sollte im Verzeichnis sich befinden und gestartet werden in der man auch die VM möchte, da das Script die VM einfach in dem sich befindende Verzeichnis erstellt und startet.

* Das Shell-Script kann mit 3 Arten gestarte werden:
  
  * Im Verzeichnis in dem sich das Script befindet.
     ```
     ./docker.sh
     ```
  * Absolute Pfad
    ```
    /data/docker/docker.sh
    ```  

  * Pfadvariable
    
    Das Script befindet sich in einem Verzeichnis das in der Pfadvariabel angegeben ist.
    ```
    echo $PATH
    ```
    * Pfadvariable anzeigen

---

## Shell Script anpassen

* Das Script kann für weitere Zwecke angepasst werden. 

* Die Parameter können verändert und auch ergänzt werden. 

---

## Sicherheit



[1]: https://de.wikipedia.org/wiki/H%C3%A4rten_(Computer) "härten"

* Systeme und VM's die im Internet (DMZ) stehe sollten immer [gehärtet][1] sein.

* Der Zugriff auf Datenbanken sollte auf die nötigsten Netze beschränkt werden und die Administration nur von einem Bestimmten Netz erlaubt werden.

* Dateinübertragungen sollten immer über eine Verschlüsselte Verbindung gemacht werden. 

* Die Sicherheit kann im Script ausgebaut werden damit es den eigenen Standards entspricht.

* Mit SSH (Secure Shell) wird eine Verschlüsselte Verbindung zu einem entferneten Rechner oder System aufgebaut. Mit dieser verschlüsselten Verbindung kann auf die Commandline zugegriffen werden und Sicher auf anderen Systemen gearbeiet werden. 


---

## Testing

### Testfälle

* Die Ordner der Container wurden erzeugt mit den richtigen Namen?

* Die VM's wurden gestartet und die Dienste laufen?

* Die OSTicket Seite ins verfügbar und das Tool kann verwendet werden? 

### Testergebnisse


---

## Fazit

* Mit einem Shellscript können sehr schnell und einfach mehrere VM's erstellt werden. 

* Es ist ganz leicht das Script für weitere Zwecke auszubauen und zu erweitern.

* Bei installationen bei dem Abfragen an den User gestellt werden kann es zu Problemen und Schwierigkeiten kommen.

* Für grössere Projekte sollten noch Fehlerbehandlung eingebaut werden und Logs um eine Übersicht zu haben welche VM's wann erstellt wurden und ob Probleme aufgetreten sind. 

---

## Relflexion

Ich habe viel über Git gelernt und mich mit dem Thema ausanander gesetzt. Mit Visual Studio Code habe ich das ganze Prozedere schon ziemlich gut im Griff um Sachen zu pushen und stagen. Ich finde Git macht in vielen Anwendungsbereichen viel sinn und werde versuchen dies in Zukunft mehr zu gebrauchen und es auch im Geschäft zu Pushen. Das Projekt mit der Vagrantbox hat mir auch viel gelernt. Nicht alles hat auf anhieb geklappt. Bei Rückfragen des OS hat sich das Script aufgehangen und konnte nicht ausgeführt werden. 

---

## Wissensgewinn

Ich habe am Anfang nicht verstanden wie man mit Vagrant einen automatisierten Webserver ausetzt, doch mit dem Projekt habe ich dies Verstanden. Auch habe ich gelernt wie man mit Git umgeht und wie man dies am besten einsetzten kann. 

---

von Robin Bobst
