# Dockerfile
FROM node:11.13.0-alpine

# Destination directory
RUN mkdir -p /nuxt-app
WORKDIR /nuxt-app

# update and install dependency
RUN apk update && apk upgrade
RUN apk add git

# copy the app, note .dockerignore
COPY . /nuxt-app/
RUN npm install
RUN npm run build

EXPOSE 3000

ENV NUXT_HOST=0.0.0.0
ENV NUXT_PORT=3000

CMD [ "npm", "start" ]