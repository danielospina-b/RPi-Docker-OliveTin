# RaspberryPi Docker OliveTin

This OliveTin Docker Image works with RaspberryPi, it has ssh installed to run the OliveTin commands using SSH.

[OliveTin](https://github.com/jamesread/OliveTin) is a web interface for running Linux shell commands. 

## Configuration

SSH is installed in order to run commands that can not be run inside a container. The /config/config.yaml file works the same way as OliveTin

config.yaml example
``` yml
actions:
  - title: WOL Server
    shell: ssh user@192.168.0.4 wakeonlan AB:CD:EF:12:34:56
```

SSH Config Files (id_rsa & known_hosts) should be mounted in /root/.ssh/

## How to run

- Create the conf/ and ssh-conf/ folders (or clone the repo)

``` bash
mkdir conf ssh-conf
```

- Modify config.yaml inside [conf/config.yaml](conf/config.yaml) with your OliveTin actions. See Official OliveTin Documentation.

- Add the _id_rsa_ and _known_hosts_ files to the [ssh-conf](ssh-conf) folder. See below on how to fill the _known_hosts_ file

```
touch conf/config.yaml ssh-conf/known_hosts
```

- Run the image

``` bash
docker run -d --name OliveTin -p 1337:1337 -v $(pwd)/conf/:/config/ -v $(pwd)/ssh-conf/:/root/.ssh/ dospina/rpi-olivetin
```

- Go to [http://localhost:1337](http://localhost:1337)

### Content of _known_hosts_

Run the docker image, get into a bash session and connect to the host that will be running the OliveTin commands.

``` bash
docker exec -it OliveTin /bin/bash

# now inside the container connect to the host
ssh <user>@<host-ip>

# disconnect from the host and this will be the content of the generated known_hosts file
cat /root/.ssh/known_hosts
# now ssh commands run from the OliveTin connect directly without prompt
```

Leave the container bash session

## TODO

- User instead of root in Dockerfile