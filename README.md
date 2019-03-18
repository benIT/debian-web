# benit/debian-web docker file

## Purpose 

This repo is sample dockerfile based on debian.

## Content

* Debian
* Apache
* PHP

## Usage

### Build

build latest version:

	docker build -t benit/debian-web . --build-arg http_proxy --build-arg https_proxy
	
or tag it: 

	docker build -t benit/debian-web . --build-arg http_proxy=$http_proxy --tag benit/debian-web:1.0.0
	

### Run

	docker run --name debian-web --rm -p 8080:80 -d benit/debian-web:latest
	
	
### Attach a shell

    docker container exec -it debian-web /bin/bash
    
### Stop

    docker container stop debian-web

or stop all running containers:

    docker stop `docker ps -a -q`