# Single-machine Hadoop and Hive Cluster

Containerized Hadoop and Hive cluster in a single machine.

# Usage

## Single machine

`docker-compose up`

## Multi machine test (swarm)

- install virtualbox (tested on 6.1.2)
- install vagrant (2.2.7)

### Setup test machine

Up the vagrant nodes
```shell script
cd vagrant
vagrant up
````

Install docker and compose on node2
```shell script
vagrant ssh node2
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
exit
```

Install docker and compose, Init docker swarm on node1
```shell script
vagrant ssh node1
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker swarm init --advertise-addr=192.168.2.11
```

(on node2 terminal)
```shell script
docker swarm join --token XXXXX 192.168.2.11:2377
```

(on node1 terminal)
```shell script
docker stack deploy -c docker-compose.yml --with-registry-auth hadoop
docker service ls (after some time)
```

## Populate

`make wordcount`

# Reference

https://github.com/big-data-europe/docker-hadoop

# Test Environment
- OSX 10.14.6