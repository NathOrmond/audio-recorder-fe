# audio-recorder-fe

> Front end for audio recorder project



## Build and Run with NPM

```bash
# install dependencies
$ npm install

# serve with hot reload at localhost:3000
$ npm run dev

# build for production and launch server
$ npm run build
$ npm run start

# generate static project
$ npm run generate
```

For detailed explanation on how things work, check out [Nuxt.js docs](https://nuxtjs.org).

## Using Docker with this Project

```bash
# build docker image 
$ docker build -t audio-recorder-fe .

# run docker container from image 
# (Alternatively run )
$ docker run -it -p 3000:3000 audio-recorder-fe

# save docker image to .tar file
$  docker save -o <path for generated tar file> <image name>

# run docker image from .tar file
$ docker load -i <path to image tar file>

```

> Alternatively run './docker-build.sh' and './docker-run.sh' to build and run respectively 


