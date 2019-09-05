<!-- https://shields.io/ -->
[![license](https://img.shields.io/github/license/peaceiris/hugo-extended-docker.svg)](https://github.com/peaceiris/hugo-extended-docker/blob/master/LICENSE)
[![release](https://img.shields.io/github/release/peaceiris/hugo-extended-docker.svg)](https://github.com/peaceiris/hugo-extended-docker/releases/latest)
[![GitHub release date](https://img.shields.io/github/release-date/peaceiris/hugo-extended-docker.svg)](https://github.com/peaceiris/hugo-extended-docker/releases)
[![GitHub Actions status](https://github.com/peaceiris/hugo-extended-docker/workflows/Docker%20Image%20CI/badge.svg)](https://github.com/peaceiris/hugo-extended-docker/actions)

<img width="400" alt="Docker image of Hugo extended version" src="./images/ogp.svg">



## Docker image of Hugo (Hugo extended and Hugo Modules)

- [peaceiris/hugo - Docker Hub]

[![Docker Hub Build Status](https://img.shields.io/docker/cloud/build/peaceiris/hugo.svg)](https://hub.docker.com/r/peaceiris/hugo)
[![docker image size](https://images.microbadger.com/badges/image/peaceiris/hugo.svg)](https://microbadger.com/images/peaceiris/hugo)

<!-- https://microbadger.com/ -->

[![DockerHub Badge](https://dockeri.co/image/peaceiris/hugo)][peaceiris/hugo - Docker Hub]

[peaceiris/hugo - Docker Hub]: https://hub.docker.com/r/peaceiris/hugo



## Getting started

### Pull docker image

```sh
# small image
export HUGO_DOCKER_TAG="v0.58.0"
# large image for Hugo Modules (Golang and Git are installed)
export HUGO_DOCKER_TAG="${HUGO_DOCKER_TAG}-mod"

docker pull peaceiris/hugo:${HUGO_DOCKER_TAG}
```

### Usage

```sh
# Run "hugo server"
docker run --rm -i -t -v $(pwd):/src -p 1313:1313 peaceiris/hugo:${HUGO_DOCKER_TAG} server

# Run with flags
docker run --rm -i -t -v $(pwd):/src -p 1313:1313 peaceiris/hugo:${HUGO_DOCKER_TAG} --gc --minify --cleanDestinationDir
```
