FROM ubuntu

# Set the working directory in the container
WORKDIR /app

# Update the package list and install curl
RUN apt-get update

RUN apt-get install -y curl

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_18.x -o /tmp/nodesource_setup.sh

RUN apt-get upgrade -y

RUN apt-get install -y nodejs

# Install npm
RUN apt-get install -y npm

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install dependencies for production
RUN npm install --legacy-peer-deps

# Copy the rest of the application code
COPY . .

# Remove the node_modules directory
RUN rm -rf node_modules

# Install dependencies for development
RUN npm install --legacy-peer-deps

EXPOSE 4005

CMD ["npm", "run", "dev"]
