docker for dosbox
=================

Run [DOSBox](https://www.dosbox.com/) in a docker container.

## Building & Running

1. Add your game archives or folders (you can get games e.g. from https://dosgames.com/)
2. Built with: `docker build -t dosbox .`
3. Start with: `docker run -p 8080:8080 dosbox` or if you use a volume `docker run -p 8080:8080 -v /local/folder/with/games:/root/dos dosbox`
4. Commit the running container: `docker commit d3c2e036ff37 davidmpaz/dosbox-tp7:1.0`
5. Connect with a browser to your docker host e.g. http://localhost:8080

## Volume

There is an exposed volume for making files accessible to the container under: `/app/src`
