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
docker run -p 22 --rm -i -d --name c0 --network common --env INVENTORY=asdfasdfasdf ansible:latest zsh
docker run -p 22 --rm -i -d --name c1 --network common --env INVENTORY=afasdfasgwee ansible:latest zsh
```

Podman:

```bash
podman network create -d bridge common
podman run -p 22 --rm -i -d --name c0 --network common --env INVENTORY=asdfasdfasdf ansible:latest zsh
podman run -p 22 --rm -i -d --name c1 --network common --env INVENTORY=afasdfasgwee ansible:latest zsh
```

## Test

From c0:

```bash
ssh ansible@c1
```

## Add Password

```bash
echo -n 'ansible:ansible' | sudo chpasswd
```
