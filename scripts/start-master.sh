#!/bin/bash

# Stop and remove existing container
echo "Stopping and removing existing container: master-server"
docker ps -q --filter "ancestor=master-server:v1" | xargs -r docker stop
docker rm master-server:v1 2>/dev/null
# Navigate to the project directory
echo "Changing directory to ~/master-server-modules/master-server"
cd ~/master-server-modules/master-server || { echo "Failed to change directory"; exit 1; }

# Pull latest changes from Git
echo "Pulling latest code from Git"
git pull || { echo "Git pull failed"; exit 1; }

# Build the Docker image
echo "Building Docker image: master-server:v1"
docker build -t master-server:v1 -f Dockerfile . || { echo "Docker build failed"; exit 1; }

# Run the new container
echo "Running the new container on port 8001"
docker run -d --network host master-server:v1 || { echo "Docker run failed"; exit 1; }

echo "Deployment completed successfully!"
