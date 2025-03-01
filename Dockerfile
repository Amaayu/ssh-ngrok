# Base Image (Ubuntu)
FROM ubuntu:latest

# Set Non-Interactive Mode to Avoid Prompt Issues
ARG DEBIAN_FRONTEND=noninteractive

# Update and Install Required Packages
RUN apt update && apt install -y openssh-server curl unzip dos2unix

# Create SSH Directory and Set Password
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd  # Default password (change later)

# Install ngrok
RUN curl -s https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -o ngrok.zip \
    && unzip ngrok.zip \
    && mv ngrok /usr/local/bin/ngrok

# Ensure /root/.ngrok2 Directory Exists Before Copying
RUN mkdir -p /root/.ngrok2

# Copy Configuration and Start Script
COPY start.sh /start.sh
COPY ngrok.yml /root/.ngrok2/ngrok.yml

# Convert start.sh to Unix Format and Make it Executable
RUN dos2unix /start.sh && chmod +x /start.sh

# Ensure start.sh has the correct shebang
RUN sed -i '1s|^|#!/bin/bash\n|' /start.sh

# Expose SSH Port
EXPOSE 22

# Auto-Start Script
CMD ["/bin/bash", "/start.sh"]
