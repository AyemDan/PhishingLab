#!/bin/bash

echo "Starting attacker services..."
cd /opt/attacker

# Create required directories
mkdir -p data

# Start Docker containers
docker-compose up -d

echo "Attacker services started:"
echo "- GoPhish Admin: http://localhost:3333"
echo "- GoPhish Server: http://localhost:8080"

# Show running containers
docker ps
