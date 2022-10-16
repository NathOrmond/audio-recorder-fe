# audio-recorder-fe

> Front end for audio recorder project

**Note** There are some issues (https://github.com/webpack/webpack/issues/14532#issuecomment-947012063) with npm version (17+) that make it incompatible 
with certain commends like `npm run dev` - please set npm to version 16.  

This can be done by using `nvm use 16` if you have nvm installed. 
If you do not do this then you will encounter issues running the project locally for development purposes.


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


