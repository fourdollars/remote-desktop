# remote-desktop

A docker image for remote desktop experiment. It still needs a lot of work.

https://hackmd.io/@fourdollars/gnome-remote-desktop

## Usage

### Setup the docker image

```bash
git clone https://github.com/fourdollars/remote-desktop.git
cd remote-desktop
docker build -t remote-desktop .
```

### Run the docker image

```bash
docker create --name remote-desktop -p 9527:3389 -it --privileged=true remote-desktop
docker start remote-desktop
docker exec -it remote-desktop /bin/bash # debug
```
or shorter
```bash
docker run -it --rm -p 9527:3389 -it --privileged=true remote-desktop
```

Here we use the port `9527` to access the remote desktop.

### Connect to the remote desktop

```bash
apt-get install --no-install-recommends remmina remmina-plugin-rdp
```

RDP login with username `u` and password `p`:
