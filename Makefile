DOCKER_COMPOSE ?= $(shell \
		docker compose version >/dev/null 2>/dev/null \
	&& echo docker compose \
	|| echo docker-compose \
	)

build:
	$(DOCKER_COMPOSE) build

start:
	$(DOCKER_COMPOSE) up --build

stop:
	$(DOCKER_COMPOSE) down

bash:
	$(DOCKER_COMPOSE) exec app-fabrica bash

console:
	$(DOCKER_COMPOSE) exec app-fabrica rails console

migrate:
	$(DOCKER_COMPOSE) exec app-fabrica rails db:migrate

create:
	$(DOCKER_COMPOSE) exec app-fabrica rails db:create

deploy:
	$(DOCKER_COMPOSE) exec app-fabrica mina deploy -v