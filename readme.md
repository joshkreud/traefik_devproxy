# Traefik Devproxy

![TraefikLogo](https://github.com/traefik/traefik/blob/master/docs/content/assets/img/traefik.logo.png?raw=true)

Local Development Traefik (reverse proxy).

Allows you to easily Proxy docker containers to "*.docker.localhost"\
Also contains [whoami](https://hub.docker.com/r/containous/whoami) and [Smtp4Dev](https://github.com/rnwood/smtp4dev).

# Setup

Copy [.env.sample](./.env.sample) to '.env'. \
Change [.env](./.env) to your needs.

```bash
make cert # Generates SSL Keypair in ./cert
make # Starts Traefik and Whoami and smtp4dev
```

## Default Domains

- http://traefik.docker.localhost --> Traefik Dashboard
- https://whoami.docker.localhost --> to Simple Whoami Instance
- http://smtp.docker.localhost --> really cool Development Smtp Catcher.

## SSL Trust

You can import the Certificate into your trusted cert store to get rid of the self signed SSL Warning locally.
