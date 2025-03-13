# Docker Setup Guide for Your Node.js Application

This guide provides step-by-step instructions to build and run your **Node.js** application using Docker.

## Prerequisites

Before you begin, ensure you have the following installed:

- [Docker](https://www.docker.com/get-started)
- Basic knowledge of terminal/command prompt

---

## **Dockerizing a Node.js Application**

This guide covers two methods:

1. **Using Ubuntu and manually installing Node.js**
2. **Using the official Node.js image** (Recommended)

---

## **1. Using Ubuntu and Installing Node.js Manually**

If you prefer a base **Ubuntu** image and want to manually install Node.js, use the following `Dockerfile`:

### **Dockerfile (Manual Node.js Installation)**

```dockerfile
# Start with Ubuntu as the base image
FROM ubuntu:latest

# Set the working directory
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install --legacy-peer-deps

# Copy application files
COPY . .

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
```

### **Build & Run**

```sh
# Build the Docker image
docker build -t my-node-app .

# Run the container
docker run -d -p 3000:3000 --name my-app my-node-app
```

---

## **2. Using the Official Node.js Image (Recommended)**

A better approach is to use the official **Node.js** image, which simplifies setup and ensures a stable environment.

### **Dockerfile (Using Node.js Image)**

```dockerfile
# Use the official Node.js image
FROM node:18

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json first (leveraging Docker cache)
COPY package*.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Copy the rest of the application
COPY . .

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
```

### **Build & Run**

```sh
# Build the Docker image
docker build -t my-node-app .

# Run the container
docker run -d -p 3000:3000 --name my-app my-node-app
```

---

## **Running the Application with Docker Compose**

Docker Compose allows managing multiple containers (frontend, backend, database) with a single command.

### **docker-compose.yaml**

```yaml
version: "3.8"

services:
  backend:
    build: .
    container_name: my-backend
    ports:
      - "3000:3000"
    volumes:
      - .:/app
    env_file:
      - .env
    depends_on:
      - mongo

  mongo:
    image: mongo
    container_name: my-mongodb
    ports:
      - "27017:27017"
    volumes:
      - mongo-data:/data/db
    environment:
      MONGO_INITDB_ROOT_USERNAME: root
      MONGO_INITDB_ROOT_PASSWORD: example

volumes:
  mongo-data:
```

### **Build & Run with Docker Compose**

```sh
# Build and start containers
docker compose up -d --build
```

- `-d`: Runs containers in detached mode
- `--build`: Forces a rebuild of the images

### **Check Running Containers**

```sh
docker ps
```

### **Stop & Remove Containers**

```sh
docker compose down
```

To remove all volumes and images:

```sh
docker compose down --rmi all --volumes
```

### **Access the Application**

Once running, access your application at:

```
http://localhost:3000
```

---

## **Additional Docker Commands**

### **View Logs of a Running Container**

```sh
docker logs my-backend
```

### **Enter the Running Container**

```sh
docker exec -it my-backend bash
```

### **Remove All Unused Docker Resources**

```sh
docker system prune -a
```

---

## **Conclusion**

You have successfully set up a Docker container for your application using **Docker Compose**. 🚀

For further customization, refer to the [Docker documentation](https://docs.docker.com/).
