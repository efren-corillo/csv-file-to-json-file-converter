#!/bin/bash

set -Eeu -o pipefail

cp --update=none .env.example .env
source .env

export USER_ID=$(id -u)
export USER_GROUP=$(id -g)

# Prompt for cleanup confirmation
echo "Would you like to clean up unused Docker objects (images, containers, networks)? This will NOT remove volumes. [y/N]"
read -r cleanup_confirm

if [[ "$cleanup_confirm" =~ ^[Yy]$ ]]; then
    echo "Stopping and removing containers, and networks for project $COMPOSE_PROJECT_NAME..."
    docker compose -p "${COMPOSE_PROJECT_NAME}" down --remove-orphans

    echo "Would you like to also remove all images used by $COMPOSE_PROJECT_NAME? [y/N]"
    read -r cleanup_images_confirm
    if [[ "$cleanup_images_confirm" =~ ^[Yy]$ ]]; then
        docker compose -p "${COMPOSE_PROJECT_NAME}" down --rmi all
    fi
fi

# echo "Checking if network exist: ${NETWORK_NAME}"

# # Check if the network exists
# network_exists=$(docker network ls --filter name=^${NETWORK_NAME}$ --format "{{.Name}}" | grep -w ${NETWORK_NAME})

# echo "network_exist: ${network_exists}"

# # If the network doesn't exist, create it
# if [ -z "$network_exists" ]; then
#     echo "Network '${NETWORK_NAME}' does not exist. Creating it..."
#     docker network create ${NETWORK_NAME}
#     if [ $? -ne 0 ]; then
#         echo "Failed to create network '${NETWORK_NAME}'"
#         exit 1
#     fi
# else
#     echo "Network '${NETWORK_NAME}' already exists. Skipping creation..."
# fi

# Debugging before building
echo "Starting Docker build..."

# Build docker
docker compose -p "${COMPOSE_PROJECT_NAME}" -f docker-compose.yml build python
if [ $? -ne 0 ]; then
    echo "Docker build failed"
    exit 1
fi

echo "Starting Docker up..."

# Remove orphans and bring up the service
docker compose -p "${COMPOSE_PROJECT_NAME}" -f docker-compose.yml up -d --remove-orphans
if [ $? -ne 0 ]; then
    echo "Docker up failed"
    exit 1
fi


echo "Deploy script completed."