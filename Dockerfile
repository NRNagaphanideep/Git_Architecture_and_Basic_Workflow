# Base Image (Nginx Web Server)

FROM nginx:alpine

# Copy our html file into Nginx default web directory
COPY index.html /usr/share/nginx/html/index.html

#Expose HTTP Port
EXPOSE 80


