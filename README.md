[![license](https://img.shields.io/github/license/peaceiris/hugo-extended-docker.svg)](https://github.com/peaceiris/hugo-extended-docker/blob/master/LICENSE)
[![release](https://img.shields.io/github/release/peaceiris/hugo-extended-docker.svg)](https://github.com/peaceiris/hugo-extended-docker/releases/latest)
[![GitHub release date](https://img.shields.io/github/release-date/peaceiris/hugo-extended-docker.svg)](https://github.com/peaceiris/hugo-extended-docker/releases)

<img width="400" alt="Docker image of Hugo extended version" src="./images/ogp.svg">



## Docker image of Hugo extended version

- [peaceiris/hugo - Docker Hub]

[![DockerHub Badge](https://dockeri.co/image/peaceiris/hugo)][peaceiris/hugo - Docker Hub]

[peaceiris/hugo - Docker Hub]: https://hub.docker.com/r/peaceiris/hugo



## Getting started

### Pull docker image

```sh
docker pull peaceiris/hugo:v0.55.6-1
```

### Usage

```sh
# Run "hugo server"
docker run --rm -i -t -v $(pwd):/src -p 1313:1313 peaceiris/hugo:v0.55.6-1 server

# Run "hugo --gc --minify --cleanDestinationDir"
docker run --rm -i -t -v $(pwd):/src -p 1313:1313 peaceiris/hugo:v0.55.6-1 --gc --minify --cleanDestinationDir
```
