#!/bin/bash

echo "Starting server services..."
cd /opt/server

# Create required directories
mkdir -p openvpn step-ca mailserver

# Start Docker containers
docker-compose up -d

echo "Server services started:"
echo "- OpenVPN Server: port 1194/udp"
echo "- Step CA: http://localhost:9000"
echo "- Mail Server: ports 25,587,993,995,9443"

# Show running containers
docker ps

echo "Server services started successfully!"
echo "Services available:"
echo "- OpenVPN: port 1194/udp"
echo "- Step CA: http://localhost:9000"
echo "- Mail Server: http://localhost:9443 (admin)"
echo "- Nginx Proxy: http://localhost:80"
echo "- NoVNC Desktop: http://localhost:8080"
