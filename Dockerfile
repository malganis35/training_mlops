# Use a python image
FROM python:3.12.0-slim

# Install make and other dependencies
RUN apt-get update && apt-get install -y \
    make \
    && rm -rf /var/lib/apt/lists/*

# Copy files to containers
COPY . /app_keyrus

# Define the working directory
WORKDIR /app_keyrus

# Run commands
RUN make prod-install
