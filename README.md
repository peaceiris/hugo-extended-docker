[![license](https://img.shields.io/github/license/peaceiris/hugo-extended-docker.svg)](https://github.com/peaceiris/hugo-extended-docker/blob/master/LICENSE)
[![release](https://img.shields.io/github/release/peaceiris/hugo-extended-docker.svg)](https://github.com/peaceiris/hugo-extended-docker/releases/latest)
[![GitHub release date](https://img.shields.io/github/release-date/peaceiris/hugo-extended-docker.svg)](https://github.com/peaceiris/hugo-extended-docker/releases)

<img width="400" alt="Docker image of Hugo extended version" src="./images/ogp.svg">



## Docker image of Hugo extended version

Docker image of Hugo extended version.

```sh
docker pull peaceiris/hugo:v0.55.6

docker build . -t peaceiris/hugo:v0.55.6

# Run "hugo server"
docker run --rm -i -t -v $(pwd):/src -p 1313:1313 peaceiris/hugo:v0.55.6 server

# Run "hugo --gc --minify --cleanDestinationDir"
docker run --rm -i -t -v $(pwd):/src -p 1313:1313 peaceiris/hugo:v0.55.6 --gc --minify --cleanDestinationDir
```
