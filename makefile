.PHONY: build run stop clean re-run exec sql

# Docker container name
CONTAINER_NAME = db-container

# Docker image name
IMAGE_NAME = hands-on-db

build:
	@echo "--- Building Docker image: $(IMAGE_NAME) ---"
	docker build -t $(IMAGE_NAME) .

run:
	@echo "--- Starting PostgreSQL container: $(CONTAINER_NAME) ---"
	docker run -d -p 5432:5432 --name $(CONTAINER_NAME) -v $(IMAGE_NAME)_db_data:/var/lib/postgresql/data -v ./sql:/app/sql $(IMAGE_NAME)

stop:
	@echo "--- Stopping PostgreSQL container: $(CONTAINER_NAME) ---"
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true

clean:
	@echo "--- Removing PostgreSQL container and volume ---"
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true
	docker volume rm $(IMAGE_NAME)_db_data || true

re-run: clean build run

exec:
	@echo "--- Connecting to PostgreSQL container ---"
	docker exec -it $(CONTAINER_NAME) psql -U postgres -d app_db
