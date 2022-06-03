.env:
	$(error file .env is missing, see .env.sample)


dev: .env
	@echo "Starting DEV Server"
	docker-compose up -d --force-recreate
stop:
	@echo "Stopping Service"
	docker-compose down --remove-orphans
cert:
	./generate_dev_cert.sh
