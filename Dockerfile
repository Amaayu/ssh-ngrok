# Base Image (Ubuntu)
FROM ubuntu:latest

# Update and Install Required Packages
RUN apt update && apt install -y openssh-server curl unzip

# Create SSH Directory and Set Password
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd  # Default password (change later)

# Install ngrok
RUN curl -s https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -o ngrok.zip \
    && unzip ngrok.zip \
    && mv ngrok /usr/local/bin/ngrok

# Copy Configuration and Start Script
COPY start.sh /start.sh
COPY ngrok.yml /root/.ngrok2/ngrok.yml
RUN chmod +x /start.sh

# Expose SSH Port
EXPOSE 22

# Auto-Start Script
CMD ["/start.sh"]
