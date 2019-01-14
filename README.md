# Content

* Debian
* Apache
* PHP 7.0

# Build

build latest version:

	docker build -t benit/debian-web . --build-arg http_proxy=$http_proxy
	
or tag it: 

	docker build -t benit/debian-web . --build-arg http_proxy=$http_proxy --tag benit/debian-web:1.0.0
	

# Run

	docker run --name debian-web --rm -p 80:80 -d benit/debian-web:latest
	
	
# Attach a shell

    docker container exec -it debian-web /bin/bash
    
# Stop

    docker container stop debian-web

or stop all running containers:

    docker stop `docker ps -a -q`



### Docker running containers inside a bridge network

The purpose of this post is to isolate each tiers of our app into different containers.

We will create a private network and run containers inside this private network.
        
[This article is largely inspired by this great resource.](https://docker-curriculum.com/#webapps-with-docker)    
# Networking

## Create an isolated private bridge network
    
    docker network create web-net    
    psql -U postgres -c "create database webapp";
    
## Inspect the private network

    docker network inspect web-net
    
## Run a container inside the private bridge network with `--net` option

    docker run --name pgsql-web --rm  -d --net web-net postgres:latest
    docker run --name debian-web --rm -p 80:80 --net web-net -d benit/debian-web:latest
    

## Inspect the private network to get IPs of containers of the private network
    
    docker network inspect web-net

gives:
    
     "Containers": {
                "3729ccbb14e514fd6c8b571ed9c985c28293cb5bfdb10c6c233773f50d6ba763": {
                    "Name": "debian-web",
                    "EndpointID": "c370cab93cdd2ac9f30f568a1709b8c998d2ca36106d5423b484a20aadbff84f",
                    "MacAddress": "02:42:ac:12:00:03",
                    "IPv4Address": "172.18.0.3/16",
                    "IPv6Address": ""
                },
                "61bcf5cd9838c8c2e66beef73a04a2704a3be7e2085a5c6b4ad58bd78f12a138": {
                    "Name": "pgsql-web",
                    "EndpointID": "128f50ead4974a725c04551cb284fec2c733a48375a4819096b0b623ff2af4ac",
                    "MacAddress": "02:42:ac:12:00:02",
                    "IPv4Address": "172.18.0.2/16",
                    "IPv6Address": ""
                }
            },

    
    
## Let's create a database

    docker container exec pgsql-web psql -U postgres -c "create database webapp";
    docker container exec pgsql-web psql -U postgres -d webapp -c "CREATE TABLE account(user_id serial PRIMARY KEY,username VARCHAR (50) UNIQUE NOT NULL,created_on TIMESTAMP NOT NULL);" ;
    docker container exec pgsql-web psql -U postgres -d webapp -c "INSERT INTO account (username,created_on ) VALUES ('foo','2019-01-01') ;" ;
    docker container exec pgsql-web psql -U postgres -d webapp -c "INSERT INTO account (username,created_on ) VALUES ('bar','2019-01-02') ;" ;
    
    
## Connect database container from webserver container

    docker container exec -it debian-web  psql -U postgres -h 172.18.0.2 -d webapp -c "select * from account;" ;
    
gives:
    
     user_id | username |     created_on      
    ---------+----------+---------------------
           1 | foo      | 2019-01-01 00:00:00
           2 | bar      | 2019-01-02 00:00:00
    (2 rows)


## Docker compose

Purpose: compose is a tool designed to create multi-containers app.

## Install

    sudo apt install python-pip
    pip install docker-compose

## docker-compose.yml

The magic happens in a file named `docker-compose.yml`
    
## Run
    
    docker-compose up -d

## Stop
    
    docker-compose down -v
    
    
# Development
      
replace this section to get your changes from your host sync with your container : 
    
    image: benit/debian-web

by:

    build:
      context: .
      args:
        - http_proxy
        - https_proxy
        - no_proxy    