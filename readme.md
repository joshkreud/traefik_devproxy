# Traefik Devproxy

![TraefikLogo](https://github.com/traefik/traefik/blob/master/docs/content/assets/img/traefik.logo.png?raw=true)

Local Development Traefik (reverse proxy).

Allows you to easily Proxy docker containers to for example "*.docker.localhost"\
Also contains [whoami](https://hub.docker.com/r/containous/whoami) and [Smtp4Dev](https://github.com/rnwood/smtp4dev).

# Setup

Copy [.env.sample](./.env.sample) to '.env'. \
Change [.env](./.env) to your needs.

```bash
make cert # Generates SSL Keypair in ./cert
make # Starts Traefik and Whoami and smtp4dev
```

## Default Domains

- http://traefik.${DOMAINNAME} --> Traefik Dashboard
- https://whoami.${DOMAINNAME} --> to Simple Whoami Instance
- http://smtp.${DOMAINNAME} --> really cool Development Email test Service.

## SSL Trust

You can import the Certificate into your trusted cert store to get rid of the self signed SSL Warning locally.
