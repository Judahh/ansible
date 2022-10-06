# Ansible

Ansible container

## Build

Docker:

```bash
docker build -t ansible .
```

Podman:

```bash
podman build -t ansible . --format docker
```

## Push

Docker:

```bash
docker push judahh/ansible:latest
```

Podman:

```bash
podman push docker.io/judahh/ansible:latest
```

## Run

Docker:

```bash
docker network create -d bridge common
docker run -p 22 --rm -i -d --name c0 --network common --env INVENTORY=asdfasdfasdf ansible:latest zsh
docker run -p 22 --rm -i -d --name c1 --network common --env INVENTORY=afasdfasgwee --env PASSWORD=ans ansible:latest zsh
```

Podman:

```bash
podman network create -d bridge common
podman run -p 22 --rm -i -d --name c0 --network common --env INVENTORY=asdfasdfasdf ansible:latest zsh
podman run -p 22 --rm -i -d --name c1 --network common --env INVENTORY=afasdfasgwee --env PASSWORD=ans ansible:latest zsh
```

## Test Connection

From c0:

```bash
ssh ansible@c1
```

## Test Ansible

From c0:

```bash
ansible-playbook -i sampleInventory.ini basic.yaml
```
