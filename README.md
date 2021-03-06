stunnel
=======

[![Build Status](https://travis-ci.org/EasyPi/docker-stunnel.svg)](https://travis-ci.org/EasyPi/docker-stunnel)
[![Docker Stars](https://img.shields.io/docker/stars/easypi/stunnel.svg)](https://hub.docker.com/r/easypi/stunnel/)

[Stunnel][1] is a proxy designed to add TLS encryption functionality to
existing clients and servers without any changes in the programs' code.

## docker-compose.yml

```yaml
server:
  image: easypi/stunnel
  ports:
    - "9080:9080"
  volumes:
    - ./data:/etc/stunnel
    - ./data/server.conf:/etc/stunnel/stunnel.conf
  restart: always

client:
  image: easypi/stunnel
  ports:
    - "9050:9050"
  volumes:
    - ./data:/etc/stunnel
    - ./data/client.conf:/etc/stunnel/stunnel.conf
  extra_hosts:
    - server:1.2.3.4
  restart: always
```

## Config Stunnel

```bash
$ mkdir -p ~/fig/stunnel/data
$ cd ~/fig/stunnel/data
$ openssl req -x509 -nodes -newkey rsa:1024 -days 365 -subj '/CN=stunnel' -keyout stunnel.key -out stunnel.crt
$ chmod 400 stunnel.key
$ vim -p server.conf client.conf
```

File: server.conf

```ini
foreground = yes
debug = warning

[socks_server]
protocol = socks
accept = 9080
cert = stunnel.crt
key = stunnel.key
```

File: client.conf

```ini
foreground = yes
debug = warning

[socks_client]
client = yes
accept = 0.0.0.0:9050
connect = server:9080
verifyPeer = yes
CAfile = stunnel.crt
```

## Start Server

```bash
$ docker-compose up -d server
```

## Start Client

```bash
$ docker-compose up -d client
$ curl -x socks5h://127.0.0.1:9050 ifconfig.co
```

## Known Issues

- [ ] I've not made [Transparent SOCKS][2] work yet.

[1]: https://www.stunnel.org/
[2]: https://www.stunnel.org/socksvpn.html
