docker for dosbox
=================

Run [DOSBox](https://www.dosbox.com/) in a docker container.

## Building

### Pre-conditions

Small tutorial on how to build multi-architecture images is advised, for 
example [this one](https://www.docker.com/blog/how-to-rapidly-build-multi-architecture-images-with-buildx/).

### Step by Step

Steps are simple: build image for desired architectures. Start a container to 
install Turbo Pascal on it. Once the container is in the desired state, 
commit it and push it to registry.

1. Add your game archives or folders (you can get games e.g. from https://dosgames.com/)
2. Built for multiple arch with:
   1. `docker buildx build . --platform=linux/arm64,linux/amd64 -t davidmpaz/dosbox-tp7:1.1 --push`
3. Start with:
   1. `docker run -p 8080:8080 davidmpaz/dosbox-tp7` or if you use a volume:
   2. `docker run -p 8080:8080 -v /local/folder/with/games:/root/dos davidmpaz/dosbox-tp7`
   3. Do modify containers if needed
4. Commit the running container:
   1. `docker commit <container_id> davidmpaz/dosbox-tp7:<version>`
5. Push job done: `docker push -a`

#### Installing Turbo Pascal

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

## Running

```
docker run -p 8080:8080 -v /local/folder/with/games:/root/dos davidmpaz/dosbox-tp7
```

Connect with a browser to your docker host e.g. http://localhost:8080

## Volume

There is an exposed volume for making files accessible to the container under: `/app/src`
