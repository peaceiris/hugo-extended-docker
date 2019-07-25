[![license](https://img.shields.io/github/license/peaceiris/hugo-extended-docker.svg)](https://github.com/peaceiris/hugo-extended-docker/blob/master/LICENSE)
[![release](https://img.shields.io/github/release/peaceiris/hugo-extended-docker.svg)](https://github.com/peaceiris/hugo-extended-docker/releases/latest)
[![GitHub release date](https://img.shields.io/github/release-date/peaceiris/hugo-extended-docker.svg)](https://github.com/peaceiris/hugo-extended-docker/releases)

<!-- https://shields.io/ -->

<img width="400" alt="Docker image of Hugo extended version" src="./images/ogp.svg">



## Docker image of Hugo extended version

- [peaceiris/hugo - Docker Hub]

[![Docker Hub Build Status](https://img.shields.io/docker/cloud/build/peaceiris/hugo.svg)](https://hub.docker.com/r/peaceiris/hugo)
[![docker image size](https://images.microbadger.com/badges/image/peaceiris/hugo.svg)](https://microbadger.com/images/peaceiris/hugo)

<!-- https://microbadger.com/ -->

[![DockerHub Badge](https://dockeri.co/image/peaceiris/hugo)][peaceiris/hugo - Docker Hub]

[peaceiris/hugo - Docker Hub]: https://hub.docker.com/r/peaceiris/hugo



## Getting started

### Pull docker image

```sh
docker pull peaceiris/hugo:v0.56.0
```

### Usage

```sh
# Run "hugo server"
docker run --rm -i -t -v $(pwd):/src -p 1313:1313 peaceiris/hugo:v0.56.0 server

# Run "hugo --gc --minify --cleanDestinationDir"
docker run --rm -i -t -v $(pwd):/src -p 1313:1313 peaceiris/hugo:v0.56.0 --gc --minify --cleanDestinationDir
```
