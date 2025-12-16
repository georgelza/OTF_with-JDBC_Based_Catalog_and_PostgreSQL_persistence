
.DEFAULT_GOAL := help
include .env

define HELP

Available commands:

- build: 		Build required Docker images (Flink with CDC and all the JAR's required)
- run:   		Start All services (Flink, PostgreSQL & Minio)

- stop:  		Stop the project
- start: 		Restart a stopped project
- down:  		Tear down the project, clean directories

- ps:    		how all running containers
- logs:  		Show/tail logs
- logsf: 		Stream logs
- watch: 		Watch logs
- fsql			Open Flink-Sql console
- jm			Open Flink Jobmanager console

endef

export HELP
help:
	@echo "$$HELP"
.PHONY: help


#	docker rmi $(docker images -q --filter "dangling=true")

build:
	@cd ../infrastructure && make pull_all && make build
.PHONY: build

run:
	@echo "🚀 Starting All services (Flink, PostgreSQL & MinIO)..."
	docker compose -f docker-compose.yml -p jdbccat up -d \
		jobmanager taskmanager \
 		postgrescat postgrescdc \
		minio minio-client \
		--remove-orphans
.PHONY: run

stop:
	docker compose stop

start:
	docker compose start

down:	
	docker compose down 
	cd data/; rm -rf flink
	cd data/; rm -rf postgrescdc
	cd data/; rm -rf postgrescat
	cd data/; rm -rf minio

ps:
	docker compose ps

logs:
	docker compose logs

logsf:
	docker compose logs -f

watch:
	watch docker compose ps

fsql:
	docker compose exec --interactive --tty jobmanager /opt/flink/bin/sql-client.sh

jm:
	docker compose exec --interactive --tty jobmanager /bin/bash