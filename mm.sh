#!/bin/bash
#
# LB2 Robin Bobst
#   - Erstellt mehrere VM's mit jeweils anderer Startseite (index.html).
#   - Erstellt mehrere VM's mit einer mysql Datenbank

for vm in web01 web02
do

    mkdir ${vm}
    cd ${vm}
    
    # Vagrantfile 
    cat <<%EOF% >Vagrantfile
        Vagrant.configure(2) do |config|
          config.vm.box = "ubuntu/xenial64"
          config.vm.network "forwarded_port", guest:80, host:8080, auto_correct: true
          config.vm.synced_folder ".", "/var/www/html"  
        config.vm.provider "virtualbox" do |vb|
          vb.memory = "256"  
        end
        config.vm.provision "shell", inline: <<-SHELL 
          sudo apt-get update
          sudo apt-get -y install apache2
          sudo apt-get -y install ufw
          sudo ufw enable
          sudo ufw allow 80/tcp
        SHELL
        end
%EOF%

    # index.html 
    cat <<%EOF% >index.html
    <html>
        <body>
            <h1>LB2 von Robin Bobst für ${vm}</h1>
        </body>
    <html>
%EOF%
    vagrant up
    cd ..

done

for vm in db01 db02
do

    mkdir ${vm}
    cd ${vm}
    
    # Vagrantfile 
    cat <<%EOF% >Vagrantfile
        Vagrant.configure(2) do |config|
          config.vm.box = "ubuntu/xenial64"
          config.vm.network "forwarded_port", guest:3306, host:3306, auto_correct: true
          config.vm.synced_folder ".", "/var/lib/mysql"  
        config.vm.provider "virtualbox" do |vb|
          vb.memory = "256"  
        end
        config.vm.provision "shell", inline: <<-SHELL 
          sudo apt-get update
          sudo apt-get -y install mysql-server
          sudo useradd -m mysql
          sudo apt-get -y install ufw
          sudo ufw enable
          sudo ufw allow from 0.0.0.0/0 to any port 3306
        SHELL
        end
%EOF%

    vagrant up
    cd ..   

done