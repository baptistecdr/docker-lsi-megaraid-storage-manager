<h3 align="center">LSI MegaRAID Storage Manager (Dockerized)</h3>
<p align="center">
    A simple Dockerfile/docker-compose to run LSI MegaRAID Storage Manager (GUI) on system that doesn't support it.
    <br>
    <a href="https://github.com/baptistecdr/lsi-megaraid-docker/issues/new">Report bug</a>
    ·
    <a href="https://github.com/baptistecdr/lsi-megaraid-docker/issues/new">Request feature</a>
</p>

<div align="center">

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/baptistecdr/lsi-megaraid-docker/ci)
![Docker Pulls](https://img.shields.io/docker/pulls/baptistecdr/lsi-megaraid-docker)
![GitHub](https://img.shields.io/github/license/baptistecdr/lsi-megaraid-docker)

</div>

## Quick start

### Docker

```shell
docker run --rm --privileged \
--mount type=bind,source="$HOME/.Xauthority",target=/root/.Xauthority \
--mount type=bind,source=/tmp/.X11-unix,target=/tmp/.X11-unix \
-e TZ="Europe/Paris" \
-e ROOT_PASSWORD="myrootpassword" \
-e DISPLAY=$DISPLAY \
--network host baptistecdr/lsi-megaraid-docker
```
* The UI should appear, click on Discover and double-click on your host
* Credentials are
  * username: root
  * password: `$ROOT_PASSWORD`

### Docker Compose

* Download docker-compose file
```shell
wget https://raw.githubusercontent.com/baptistecdr/lsi-megaraid-docker/main/docker-compose.yml
```
* Change the timezone and the root password in `docker-compose.yml`
* Run `docker-compose up`
* The UI should appear, click on Discover and double-click on your host
* Credentials are
  * username: root
  * password: `$ROOT_PASSWORD`

## Bugs and feature requests

Have a bug or a feature request? Please first search for existing and closed issues. If your problem or idea is not
addressed yet, [please open a new issue](https://github.com/baptistecdr/lsi-megaraid-docker/issues).

## Contributing

Contributions are welcome!
