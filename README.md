## Supported tags and respective `Dockerfile` links

* [`python3.7-alpine3.8`, `latest` _(Dockerfile)_](traefik1.7-python3.7-alpine3.8/Dockerfile)

# traefik-gunicorn-flask
This project is base on **[meinheld-gunicorn-flask-docker](https://github.com/tiangolo/meinheld-gunicorn-flask-docker)** which already pack Gunicorn and Flask very well. 

**GitHub repo**: [https://github.com/WaynePN/traefik-gunicorn-flask/](https://github.com/WaynePN/traefik-gunicorn-flask)

**Docker Hub image**: [https://hub.docker.com/r/waynepn/traefik-gunicorn-flask/](https://hub.docker.com/r/waynepn/traefik-gunicorn-flask/)

## Technical Details

### Traefik

**Traefik** is a high-performance cloud native edge router writen in Golang.

## How to use

* You don't need to clone the GitHub repo. You can use this image as a base image for other images, using this in your `Dockerfile`:

```Dockerfile
FROM waynepn/traefik-gunicorn-flask

COPY ./app /app
```

It will expect a file at `/app/app/main.py`.

Or otherwise a file at `/app/main.py`.

And will expect it to contain a variable `app` with your "WSGI" application.

Then you can build your image from the directory that has your `Dockerfile`, e.g:

```bash
docker build -t myimage ./
```

## Advanced usage

### Environment variables

These are the environment variables that you can set in the container to configure it and their default values:

#### Gunicorn variables

##### `APP_MODULE`

The string with the Python module and the Flask application variable name passed to Gunicorn.

By default:

* `main:app` 

For example, if your main file was at `/app/custom_app/custom_main.py`, you could set it like:

```bash
docker run -d -p 80:80 -e APP_MODULE="custom_app.custom_main:app" myimage
```

##### `GUNICORN_CONF`

The string path of Gunicorn python config file.
By default:
* `/gunicorn_conf.py` 

##### `WORKERS_PER_CORE`

This image will check how many CPU cores are available in the current server running your container.

It will set the number of workers to the number of CPU cores multiplied by this value.

By default:

* `2`

You can set it like:

```bash
docker run -d -p 80:80 -e WORKERS_PER_CORE="3" myimage
```

If you used the value `3` in a server with 2 CPU cores, it would run 6 worker processes.

You can use floating point values too.

So, for example, if you have a big server (let's say, with 8 CPU cores) running several applications, and you have an ASGI application that you know won't need high performance. And you don't want to waste server resources. You could make it use `0.5` workers per CPU core. For example:

```bash
docker run -d -p 80:80 -e WORKERS_PER_CORE="0.5" myimage
```

In a server with 8 CPU cores, this would make it start only 4 worker processes.

##### `LOG_LEVEL`

The log level for Gunicorn.

One of:

* `debug`
* `info`
* `warning`
* `error`
* `critical`

By default:

* `info`.

If you need to squeeze more performance sacrificing logging, set it to `warning`, for example:

You can set it like:

```bash
docker run -d -p 80:80 -e LOG_LEVEL="warning" myimage
```

#### Traefik variables

##### `TRAEFIK_CINFIG`

The string path of Traefik config file.

By default:

* `/etc/traefik/traefik.toml`.

If you have custom Traefik file, for example:

You can set it like:

```bash
docker run -d -p 80:80 -e TRAEFIK_CINFIG="/app/traefik.toml" myimage
```

You can define listen port in Traefik config file, by default **listen port is 80**.

 

