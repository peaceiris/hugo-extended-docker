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
