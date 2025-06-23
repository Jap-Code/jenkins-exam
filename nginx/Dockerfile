FROM nginx:latest

RUN apt update && apt install -y curl
RUN rm /etc/nginx/conf.d/default.conf

COPY nginx_config.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080