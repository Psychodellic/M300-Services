# M300-Services

* Erklärung vom Code
* Shell Script starten
* Shell Script anpassen

---

## Erklärung vom Code

Das Script erstellen automatisiert 2x WebVM's mit apache Webserver und 2x DBVM's mit installierten mysql-Datenbank.

Das Shell-Script wird mit zwei for Schleifen gelöst welche die VM's erstellt. 


```
Vagrant.configure(2) do |config|
          config.vm.box = "ubuntu/xenial64"
```

Mit dem `config.vm.box`    



von Robin Bobst
