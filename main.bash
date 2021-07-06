#!/bin/bash

# Atualização dos pacotes da máquina
apt update

#Instalação do Apache, do Node.JS e do NPK,
apt install apache2
apt install nodejs
apt install npm

#Clonagem da aplicação
git clone https://github.com/henriqueramosqs/ExemploNode@github.com:/var/www/demo

#Dowload do pm2 em escopo global
npm install -g pm2

#Start da aplicação (fazer dentro do diretório /var/www/demo/ExemploNode)
pm2 start Express.js

#Setup do script de Startup do pm2
pm2 startup systemd

#->Copiar o env retornado e colar no teminal
sudo env PATH=$PATH:/usr/bin /usr/local/lib/node_modules/pm2/bin/pm2 startup systemd -u ubuntu --hp /home/ubuntu

#Habilitação dos módulos proxy e proxy_http do Apache2
a2enmod proxy
a2enmod proxy_http

#Criação da pasta de configurações do servidor em /etc/apach2/sites-available

cd /etc/apache2/sites-available

nano myapp.conf

'<
Colar o trecho 

<VirtualHost *:80>
 
    	ServerName <nome_do_domínio>
    	ServerAlias <nome_alternativo_de_domínio>
    	ProxyPreserveHost on
      ProxyPass / http://localhost:<porta_da_aplicação>/
      ProxyPassReverse / http://localhost:<porta-da_aplicação>/
 
</VirtualHost>


e salvar o arquivo
>'

#Habilitar as configurações
a2ensite myapp.conf
 
#Reiniciar o servido
service apache2  restart



