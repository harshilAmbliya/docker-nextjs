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

## **Steps to Run the Application with Docker**

### **1. Build the Docker Image**

```sh
docker build -t my-app .
```

- `-t my-app`: Tags the image with the name `my-app`
- `.`: Uses the current directory as the build context

### **2. Run the Docker Container**

```sh
docker run -d -p 3000:3000 --name my-container my-app
```

- `-d`: Runs the container in detached mode
- `-p 3000:3000`: Maps port 3000 of the container to port 3000 on the host
- `--name my-container`: Names the running container `my-container`
- `my-app`: The image name

### **3. Check Running Containers**

```sh
docker ps
```

To see all containers (including stopped ones):

```sh
docker ps -a
```

### **4. Access the Application**

Once the container is running, you can access the application in your browser at:

```
http://localhost:3000
```

### **5. Stop and Remove the Container**

```sh
docker stop my-container
```

To remove the stopped container:

```sh
docker rm my-container
```

To remove the image:

```sh
docker rmi my-app
```

---

## **Additional Commands**

### **View Logs of a Running Container**

```sh
docker logs my-container
```

### **Enter the Running Container**

```sh
docker exec -it my-container bash
```

### **Remove All Unused Docker Resources**

```sh
docker system prune -a
```

---

## **Conclusion**

You have successfully set up a Docker container for your application. 🚀

For further customization, refer to the [Docker documentation](https://docs.docker.com/).
