# Traefik Devproxy

Local Development Traefik (reverse proxy).

Allows you to easily Proxy docker containers to "*.docker.localhost"

## Setup

Copy [.env.sample](./.env.sample) and remove `.sample` suffix. Change to your needs.

```bash
make cert # Generates SSL Keypair in ./cert
make # Starts Traefik and Whoami
```

Go to [http://traefik.docker.localhost](http://traefik.docker.localhost) to see if http connection works.\
Go to [https://whoami.docker.localhost](https://whoami.docker.localhost) to see if secure connection works.

You can import the Certificate into your trusted Cert store to get rid of the self signed SSL Warning.
