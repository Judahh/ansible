# ansible
Ansible container

## Build
Docker:

```bash
docker build -t ansible .
```

Podman:

```bash
podman build -t ansible .
```

## Run

Docker:

```bash
docker network create -d bridge common
docker run -p 22 --rm -ti -d --name c0 --network common ansible:latest bash
docker run -p 22 --rm -ti -d --name c1 --network common ansible:latest bash
```

Podman:

```bash
podman network create -d bridge common
podman run -p 22 --rm -ti -d --name c0 --network common ansible:latest bash
podman run -p 22 --rm -ti -d --name c1 --network common ansible:latest bash
```

## Test

From c0:

```bash
ssh ansible@c1
```
