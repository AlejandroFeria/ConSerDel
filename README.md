# README

Conexion con Fedes implementando la gema

Things you may want to cover:

* Ruby version 2.5.7
* Rails 5.2.4

* System dependencies

* Configuration
* Usuario y contraseña de la base de datos se guarda desde variables globales la configuracion de esta esta en database.yml

* Database creation

* rails db:create
* rails db:migrate

* Creacion de la configuracion 
*rails migrate_data:all

Se implemento ActviceAdmin para poder ver la creacion de las paqueterias y las llaves que requieren
localhost:3000/adminstration
El usuario por defecto es admin_user@conserdel.mx contraseña conserdel0123

Instrucciones para correr el programa despues de haber creado la base
* redis-server
* bundle exec sidekiq
* whenever --update-crontab --set environment=development




* ...
