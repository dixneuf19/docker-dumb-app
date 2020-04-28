NAME = dixneuf19/docker-dumb-app
EXPOSE_PORT = 3000
  
default: build

build:
	docker build -t $(NAME) .

push:
	docker push $(NAME)

run:
	docker run --rm -p EXPOSE_PORT:8080 $(NAME)

install-docker:
	scripts/install_docker.sh

release: build push