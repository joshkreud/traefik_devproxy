.PHONY: cert

.env:
	$(error file .env is missing, see .env.sample)

dev: .env
	./scripts/check_container_requirements.sh
	@echo "Starting DEV Server"
	docker-compose up -d --force-recreate
stop:
	@echo "Stopping Service"
	docker-compose down --remove-orphans
cert:
	./scripts/generate_dev_cert.sh
