docker for dosbox
=================

Run [DOSBox](https://www.dosbox.com/) in a docker container. And install 
development tools for pascal and assembly.

### Pre-conditions

Small tutorial on how to build multi-architecture images is advised, for
example [this one](https://www.docker.com/blog/how-to-rapidly-build-multi-architecture-images-with-buildx/).

## What's this about

Out of this repository was obtained several docker images:

### Multi-architecture base image

https://hub.docker.com/repository/docker/davidmpaz/dosbox-tp7-uninstalled

This can be used as base image if you need so. It supports **arm64** and 
**amd64** as well. If you ever need to support another architecture just 
include it when building this project:

```
docker buildx build . --platform=linux/arm64,linux/amd64,linux/ppc64le -t davidmpaz/dosbox-tp7-uninstalled --push
```

This image does not have yet Turbo Pascal installed.

### Linux amd64 and arm64 images

https://hub.docker.com/repository/docker/davidmpaz/dosbox-tp7

These are platform specific since manual steps were required to install Turbo 
Pascal. After installing it and manually committing the image the multi-arch 
nature was lost.

The example follows the arm64 platform, the amd64 is the same but changing tag
name accordingly.

If you run the image to build pascal code on Mac M1 or onward, use arm64 tag,
for Windows PC or Mac with Intel Chip, use amd64 tag. For example: `docker pull davidmpaz/dosbox-tp7:1.1-arm64`

To build it:

```
# build the image
docker buildx build . --platform=linux/arm64,linux/amd64 -t davidmpaz/dosbox-tp7:1.1-arm64 --push
# run it
docker run --rm -p 8080:8080 -v $(pwd):/app/src/ davidmpaz/dosbox-tp7:1.1-arm64
# install manually Turbo Pascal
docker ps -a # to get container id
# commit changes done
docker commit <container id> davidmpaz/dosbox-tp7:1.1-arm64
# push updated image
docker push davidmpaz/dosbox-tp7:1.1-arm64
```

### Installing Turbo Pascal

On point 3.3, TPC is installed, mostly following instructions from [here](https://github.com/johangardhage/dos-tpdemos).

After this, the image created most probably is already specific to the 
platform where the manual steps were done, this mean. To have an image amd64,
manual step for installing tp7 should be done in an amd64 device.

```
C:\> cd tpsetup
C:\TPSETUP> install.exe
```

In the installation program, select the following options
```
   Enter the SOURCE drive to use: C
   Enter the SOURCE Path: \TPSETUP
   Install Turbo Pascal on a Hard Drive
   Start Installation
```

Turbo Assembler was downloaded from https://sourceforge.net/projects/guitasm8086/

## Running

```
docker run --rm -p 8080:8080 -v $(pwd):/app/src/ davidmpaz/dosbox-tp7:1.1-arm64
```

Connect with a browser to your docker host e.g. http://localhost:8080

## Volume

There is an exposed volume for making files accessible to the container under: `/app/src`
