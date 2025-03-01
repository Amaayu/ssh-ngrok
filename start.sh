#!/bin/bash

# Start SSH Server
service ssh start

# Start ngrok (Tunnel for SSH)
ngrok start --config /root/.ngrok2/ngrok.yml --all
