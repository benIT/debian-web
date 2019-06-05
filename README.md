# benit/debian-web docker file

## Purpose 

This repo is sample dockerfile based on debian.

## Get image

Image is available at [dockerhub](https://cloud.docker.com/repository/docker/benit/debian-web)

Get it with:

    docker pull benit/debian-web:php7.1

## Content

* Debian
* Apache
* PHP
* Frontend stuffs

## Usage

### Build

build latest version:

	docker build -t benit/debian-web . --build-arg http_proxy --build-arg https_proxy
	
or tag it: 

	docker build -t benit/debian-web . --build-arg http_proxy --build-arg https_proxy --build-arg GIT_CONFIG_FILE="$(cat ~/.gitconfig)"  --tag benit/debian-web:php5.6
	
### Run

	docker run --name debian-web --rm -p 8080:80 -p 443:443 -d benit/debian-web:latest
	
### Attach a shell

    docker container exec -it debian-web /bin/bash
    
### Stop

    docker container stop debian-web

or stop all running containers:

    docker stop `docker ps -a -q`