# Continuous Integration

## Automate builds

### Docker

Manual build:

```
$ docker build -t equisense/nrf5-builder .
```

Download image from Docker Hub:

```
docker pull equisense/nrf5-builder
```

### Building

In order to compile and generate package from the container using the Makefile, run:

```
$ docker run --rm -v `pwd`:/home/project equisense/nrf5-builder make dfu_package
```
