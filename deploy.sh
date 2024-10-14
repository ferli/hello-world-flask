#!/bin/bash

# Variables
PROJECT_DIR="/home/ferli/hello-world-flask"  # Your project directory
DEPLOY_DIR="$PROJECT_DIR/deployment"         # Directory for deployment-ready files
REMOTE_USER="fdi"                            # Your remote VPS username
REMOTE_HOST="rinji.id"                       # Your remote VPS IP or hostname
REMOTE_PATH="/var/www/hello-world-flask"     # Destination path on the VPS

# Step 1: Create a deployment directory if it doesn't exist
echo "Creating deployment directory..."
mkdir -p "$DEPLOY_DIR"

# Step 2: Copy relevant files to the deployment directory
echo "Copying necessary files to deployment directory..."
cp "$PROJECT_DIR"/*.py "$DEPLOY_DIR/"
cp "$PROJECT_DIR/Dockerfile" "$DEPLOY_DIR/"
cp "$PROJECT_DIR/requirements.txt" "$DEPLOY_DIR/"

# Optionally, copy tests or other relevant directories
if [ -d "$PROJECT_DIR/tests" ]; then
    cp -r "$PROJECT_DIR/tests" "$DEPLOY_DIR/"
fi

# Step 3: Use sudo to create the directory on the production server (no password required)
echo "Creating remote directory on the production server with sudo..."
ssh "$REMOTE_USER@$REMOTE_HOST" "sudo mkdir -p $REMOTE_PATH && sudo chown $REMOTE_USER:$REMOTE_USER $REMOTE_PATH"

# Step 4: SCP the files to the production server
echo "Transferring files to production server..."
scp -r "$DEPLOY_DIR/"* "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"

# Step 5: Clean up the deployment directory
echo "Cleaning up deployment directory..."
rm -rf "$DEPLOY_DIR"

echo "Deployment files transferred successfully!"
