FROM node:8.15.0-alpine as builder

ARG GIT_MAIL
ARG GIT_USER

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
RUN git config --global user.email ${GIT_MAIL} \
    && git config --global user.name ${GIT_USER}

# build application
WORKDIR /app
RUN ng new gce-container-sample
WORKDIR /app/gce-container-sample
RUN npm install \
    && ng build --prod \
    && zip -r app.zip dist/gce-container-sample

FROM nginx:1.15.8-alpine

# deploy
COPY default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/gce-container-sample/app.zip /usr/share/nginx/html
WORKDIR /usr/share/nginx/html
RUN unzip app.zip
