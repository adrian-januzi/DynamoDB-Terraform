start:
	docker-compose -f docker-compose.yml run --rm terraform init
	docker-compose -f docker-compose.yml run --rm terraform plan
	docker-compose -f docker-compose.yml run --rm terraform apply --auto-approve

	docker-compose -f docker-compose.yml down

stop:
	docker-compose -f docker-compose.yml run --rm terraform destroy --auto-approve
	docker-compose -f docker-compose.yml down