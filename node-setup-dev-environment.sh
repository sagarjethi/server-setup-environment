#!/bin/bash

# Update and Upgrade the System
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install Required Tools
echo "Installing essential tools..."
sudo apt install -y curl wget git build-essential software-properties-common

# Install Git
echo "Installing Git..."
sudo apt install -y git

# Configure Git (Optional)
echo "Configuring Git..."
echo "Enter your Git username: "
read GIT_USERNAME
git config --global user.name "$GIT_USERNAME"

echo "Enter your Git email: "
read GIT_EMAIL
git config --global user.email "$GIT_EMAIL"

# Install NVM and Node.js
echo "Installing NVM (Node Version Manager)..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Install Latest Node.js
echo "Installing latest Node.js using NVM..."
nvm install --lts

# Install Nginx
echo "Installing Nginx..."
sudo apt install -y nginx

# Install Python and Pip
echo "Installing Python and Pip..."
sudo apt install -y python3 python3-pip

# Install Docker
echo "Installing Docker..."
sudo apt install -y apt-transport-https ca-certificates gnupg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Install Docker Compose
echo "Installing Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/2.31.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install PM2 (Process Manager for Node.js)
echo "Installing PM2..."
npm install -g pm2

# Install MongoDB
echo "Installing MongoDB..."
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
sudo apt update
sudo apt install -y mongodb-org

# Install Certbot for SSL Certificates
echo "Installing Certbot..."
sudo apt install -y certbot python3-certbot-nginx

# Enable and Start Services
echo "Enabling and starting Nginx and MongoDB..."
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl enable mongod
sudo systemctl start mongod

# Clean Up
echo "Cleaning up..."
sudo apt autoremove -y
sudo apt autoclean -y

# Finish
echo "Setup completed successfully!"
echo "Git, NVM, Node.js, Nginx, Docker, Docker Compose, MongoDB, and other tools are installed."
echo "Git configuration:"
git config --list
