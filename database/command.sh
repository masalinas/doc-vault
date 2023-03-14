#!/usr/bin/env bash

# Bring down the compose
docker compose -f ./database/docker-compose.yml down

# Bring up the compose
docker compose -f ./database/docker-compose.yml up -d