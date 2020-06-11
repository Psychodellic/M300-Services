# M300-Services

* Erklärung vom Code
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

Das Script erstellen automatisiert 2x WebVM's mit apache Webserver und 2x DBVM's mit installierten mysql-Datenbank.

Das Shell-Script wird mit zwei for Schleifen gelöst welche die VM's erstellt. 

```
#!/bin/bash
```

* Mit dem Befehl `#!/bin/bash` wird dem System gesagt das die Umgebung mit der Bash aufegbaut werden soll. Das System weiss das es für dieses Shellscript die Bash verwenden muss.  

```
Vagrant.configure(2) do |config|
          config.vm.box = "ubuntu/xenial64"
```

* Mit dem `config.vm.box` wird aus der Vagrant Cloud eine bestimmte Box heruntergeladen

```
config.vm.network "forwarded_port", guest:80, host:8080, auto_correct: true
```
* Mit `config.vm.network` werden die Netzwerk Einstellungen der VM gemacht. In diesem beispiel wird der Port 80 auf den port 8080 weitergeleitet 

```
config.vm.synced_folder ".", "/var/www/html"
```

* Der Ordner `/var/www/html` wird mit dem vagrant-VM Verzeichnis synchronisiert und es können änderungenam HTML File vorgenommen werden. 

```
config.vm.provider "virtualbox" do |vb|
          vb.memory = "256"  
```

* Hier wird angegeben wie viel RAM die einzelne VM erhält

```
config.vm.provision "shell", inline: <<-SHELL 
          sudo apt-get update
          sudo apt-get -y install apache2
          sudo apt-get -y install ufw
          sudo ufw enable
          sudo ufw allow 80/tcp
        SHELL
        end
```

* In diesem Abschnitt wird in der Shell des Betriebsystems Befehle abgesetzt. So können Pakete installiert und Konfiguarionen vorgenommen werden.
  
  Hier wird `apache` & `ufw Firewall` installiert
  Die `ufw Firewall ` wird aktiviert und der Port 80 wird geöffnet.

```
# index.html 
    cat <<%EOF% >index.html
    <html>
        <body>
            <h1>LB2 von Robin Bobst für ${vm}</h1>
        </body>
    <html>
```

* In diesem Abschnitt wird das index.html angepasst und erstellt. Dieses index.html kann beliebig ausgeschmückt werden.

```
vagrant up
    cd ..
```

* Die VM wir mit `vagrant up` gestartet und das Verzeichnis wird nach dem start verlassen

```
config.vm.provision "shell", inline: <<-SHELL 
          sudo apt-get update
          sudo apt-get -y install mysql-server
          sudo useradd -m mysql
          sudo apt-get -y install ufw
          sudo ufw enable
          sudo ufw allow from 0.0.0.0/0 to any port 3306
        SHELL
        end
```
* Hier wird für die Datenbank-VM's die Datenbank (`mysql-server`) installiert und ein User mit dem Namen `mysql` erstellt.
  Ebenfalls wird die `ufw Firewall` installiert und der Port `3306` wird für alle Netzwerke geöffent, dass jedes Netzwerk auf die Datenbank zugreifen und verwalten kann. 
  Die kann bei Sycherheitsrelevanten Datenbanken eingegrenzt werden.

```
vagrant up
    cd ..   
```
* die VM's werden gestartet und das Verzeichnis wird verlassen um die nächte VM aufzubauen. 


---

## Shell Script starten

* Das Script sollte im Verzeichnis sich befinden und gestartet werden in der man auch die VM möchte, da das Script die VM einfach in dem sich befindende Verzeichnis erstellt und startet.

* Das Shell-Script kann mit 3 Arten gestarte werden:
  
  * Im Verzeichnis in dem sich das Script befindet.
     ```
     ./mm.sh
     ```
  * Absolute Pfad
    ```
    /e/M300/vagrant/mm.sh
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

* Die Firewall hat die Ports 80 und 3306 geöffnet.
	
  * Port 80:
	
    * Wird für die Webserver benötigt.
	

  * Port 3306:
	
      * Wird für die DB-Server benötigt, und ist offen für alle.
		Eigentlich ist das überhaupt nicht gut, dass es offen für alle ist, aber da unsere VMs die IP vom DHCP beziehen, ist uns unklar welches Netz wir freigeben müssen.


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

* Wurde die index.html Seite erzeugt und ist dieses Aufrufbar? 

### Testergebnisse


* Im Verzeichnis in dem das Shellscript gestartet wurde sollte nach erfolgreichen durchlaufen des Scripts vier Ordner mit den Namen `web01`, `web02`, `db01` & `db02` erstellt worden sein.
  
![Ordner](ordner.png)

https://ibb.co/dkSSpbH
  
* Die vier VM's laufen und die Dienste sind installiert.

![Container](Container.png)

https://ibb.co/tKnXF0w

* Die index.hmtl Seite die erzeugt wurde ist aufrufbar. 

![index.html](index.png)

https://ibb.co/fNV6xdf

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

von Robin Bobst
