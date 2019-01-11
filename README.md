# Content

* Debian
* Apache
* PHP 7.0

# Build

	docker build -t benit/debian-web . --build-arg http_proxy=$http_proxy

# Run

	docker run --name debian-web --rm -p 80:80 -d benit/debian-web:latest
	
	
# Attach a shell

    docker container exec -it debian-web /bin/bash
    
# Stop

    docker container stop debian-web    