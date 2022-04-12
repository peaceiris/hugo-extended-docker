<!-- https://shields.io/ -->
[![license](https://img.shields.io/github/license/peaceiris/hugo-extended-docker.svg)](https://github.com/peaceiris/hugo-extended-docker/blob/main/LICENSE)
[![release](https://img.shields.io/github/release/peaceiris/hugo-extended-docker.svg)](https://github.com/peaceiris/hugo-extended-docker/releases/latest)
[![GitHub release date](https://img.shields.io/github/release-date/peaceiris/hugo-extended-docker.svg)](https://github.com/peaceiris/hugo-extended-docker/releases)
![Docker Image Push](https://github.com/peaceiris/hugo-extended-docker/workflows/Docker%20Image%20Push/badge.svg?branch=main&event=push)

<img width="400" alt="Docker image of Hugo extended version" src="https://raw.githubusercontent.com/peaceiris/hugo-extended-docker/main/images/ogp.svg">



## Alpine Base Docker Image for Hugo (Hugo extended and Hugo Modules)

- [peaceiris/hugo - Docker Hub]

[![DockerHub Badge](https://dockeri.co/image/peaceiris/hugo)][peaceiris/hugo - Docker Hub]

[peaceiris/hugo - Docker Hub]: https://hub.docker.com/r/peaceiris/hugo

Docker images on GitHub Packages [ghcr.io/peaceiris/hugo] are also available.

[ghcr.io/peaceiris/hugo]: https://github.com/users/peaceiris/packages/container/package/hugo



## Getting started

| Image tag | Base Image | Image size | Notes |
|---|---|---|---|
| `peaceiris/hugo:v0.x.x` | `alpine:3.15` | 74MB | Minimum image |
| `peaceiris/hugo:v0.x.x-mod` | `golang:1.18-alpine3.15` | 367MB | Hugo Modules feature is available |
| `peaceiris/hugo:v0.x.x-full` | `golang:1.18-alpine3.15` | 420MB | Hugo Modules and Node.js are available |
| `ghcr.io/peaceiris/hugo:v0.x.x` | `alpine:3.15` | 74MB | GitHub Packages: Minimum image |
| `ghcr.io/peaceiris/hugo:v0.x.x-mod` | `golang:1.18-alpine3.15` | 367MB | GitHub Packages: Hugo Modules feature is available |
| `ghcr.io/peaceiris/hugo:v0.x.x-full` | `golang:1.18-alpine3.15` | 420MB | GitHub Packages: Hugo Modules and Node.js are available |

The image size is a result of the `docker images` command.

- Hugo Modules: `hugo mod`
- Hugo Modules and Node.js: `hugo mod`, `node` and `npm`

### (1) Docker Compose

Create your `docker-compose.yml` like the following.

```yaml
version: '3'

services:
  hugo:
    container_name: hugo
    image: peaceiris/hugo:v0.x.x            # Minimum image
    # image: peaceiris/hugo:v0.x.x-mod      # Hugo Modules
    # image: peaceiris/hugo:v0.x.x-full     # Hugo Modules and Node.js
    # image: ghcr.io/peaceiris/hugo:v0.x.x  # Docker images on GitHub Packages
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



## GitHub Actions for Hugo

The Hugo Setup GitHub Action is recommended.

- [peaceiris/actions-hugo: GitHub Actions for Hugo ⚡️ Setup Hugo quickly and build your site fast. Hugo extended, Hugo Modules, Linux (Ubuntu), macOS, and Windows are supported.](https://github.com/peaceiris/actions-hugo)



## License

- [MIT License - peaceiris/hugo-extended-docker]

[MIT License - peaceiris/hugo-extended-docker]: https://github.com/peaceiris/hugo-extended-docker/blob/main/LICENSE



## Maintainer

- [peaceiris homepage](https://peaceiris.com/)
