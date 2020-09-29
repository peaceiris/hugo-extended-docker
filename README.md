<!-- https://shields.io/ -->
[![license](https://img.shields.io/github/license/peaceiris/hugo-extended-docker.svg)](https://github.com/peaceiris/hugo-extended-docker/blob/main/LICENSE)
[![release](https://img.shields.io/github/release/peaceiris/hugo-extended-docker.svg)](https://github.com/peaceiris/hugo-extended-docker/releases/latest)
[![GitHub release date](https://img.shields.io/github/release-date/peaceiris/hugo-extended-docker.svg)](https://github.com/peaceiris/hugo-extended-docker/releases)
![Docker Image Push](https://github.com/peaceiris/hugo-extended-docker/workflows/Docker%20Image%20Push/badge.svg?branch=main&event=push)

<img width="400" alt="Docker image of Hugo extended version" src="./images/ogp.svg">



## Alpine Base Docker Image for Hugo (Hugo extended and Hugo Modules)

- [peaceiris/hugo - Docker Hub]

[![Docker Hub Build Status](https://img.shields.io/docker/cloud/build/peaceiris/hugo.svg)](https://hub.docker.com/r/peaceiris/hugo)
[![docker image size](https://images.microbadger.com/badges/image/peaceiris/hugo.svg)](https://microbadger.com/images/peaceiris/hugo)

<!-- https://microbadger.com/ -->

[![DockerHub Badge](https://dockeri.co/image/peaceiris/hugo)][peaceiris/hugo - Docker Hub]

[peaceiris/hugo - Docker Hub]: https://hub.docker.com/r/peaceiris/hugo



## Getting started

| Image tag | Base Image | Image size | Notes |
|---|---|---|---|
| `peaceiris/hugo:v0.x.x` | `alpine:3.12` | 74MB | Small image |
| `peaceiris/hugo:v0.x.x-mod` | `golang:1.15-alpine3.12` | 367MB | Hugo Modules feature is available |
| `peaceiris/hugo:v0.x.x-full` | `golang:1.15-alpine3.12` | 420MB | Hugo Modules and Node.js are available |

The image size is a result of the `docker images` command.

- Hugo Modules: `hugo mod`
- Hugo Modules and Node.js: `hugo mod` and `hugo mod npm`

### (1) Docker Compose

Create your `docker-compose.yml` like the following.

```yaml
version: '3'

services:
  hugo:
    container_name: hugo
    image: peaceiris/hugo:v0.x.x
    # image: peaceiris/hugo:v0.x.x-mod   # Hugo Modules
    # image: peaceiris/hugo:v0.x.x-full  # Hugo Modules and Node.js
    ports:
      - 1313:1313
    volumes:
      - ${PWD}:/src
    command:
      - server
      - --bind=0.0.0.0
      - --buildDrafts
```

### (2) Usage

```sh
# Run "hugo server"
docker-compose up

# Build site
docker-compose run --rm hugo ""
# Build site with flags
docker-compose run --rm hugo --gc --minify --cleanDestinationDir

# Run a command of Hugo
docker-compose run --rm hugo env
```



## License

- [MIT License - peaceiris/hugo-extended-docker]

[MIT License - peaceiris/hugo-extended-docker]: https://github.com/peaceiris/hugo-extended-docker/blob/main/LICENSE



## Maintainer

- [peaceiris homepage](https://peaceiris.com/)
