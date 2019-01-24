FROM node:8.15.0-alpine as builder

# install angular-cli
RUN chown -R node:node /usr/local/lib/node_modules \
    && chown -R node:node /usr/local/bin
USER node
RUN npm install -g @angular/cli@6.0.0

# npm
USER root
RUN ng set --global packageManager=npm

# add package
RUN apk add --update git zip

# git config
RUN git config --global user.email "aoyagisan@hotmail.com" \
    && git config --global user.name "aoyagi9936"

# build application
WORKDIR /app
RUN ng new gcp-cicd-example
WORKDIR /app/gcp-cicd-example
RUN npm install \
    && ng build --prod \
    && zip -r deploy.zip dist/gcp-cicd-example

FROM nginx:1.15.8-alpine

# deploy
COPY default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/gcp-cicd-example/deploy.zip /usr/share/nginx/html
WORKDIR /usr/share/nginx/html
RUN unzip deploy.zip
