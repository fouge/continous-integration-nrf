# Continuous Integration

## Automate builds

```
$ docker build -t docker_nrf_build .
$ docker run --rm -v `pwd`:/home/project docker_nrf_build make dfu_package
```