FROM tiangolo/meinheld-gunicorn-flask:python3.7-alpine3.8

LABEL maintainer="Wayne Chung<waynepn555@gmail.com>"

ENV TRAEFIK_VERSION 1.7.11

# Standard set up Traefik Alpine
# https://github.com/containous/traefik-library-image/blob/f0bf31c38dd9c6ff5a50aaa42f3dc679e3265a20/alpine/Dockerfile

RUN apk --no-cache add ca-certificates tzdata
RUN set -ex; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		armhf) arch='arm' ;; \
		aarch64) arch='arm64' ;; \
		x86_64) arch='amd64' ;; \
		*) echo >&2 "error: unsupported architecture: $apkArch"; exit 1 ;; \
	esac; \
	wget -O /usr/local/bin/traefik "https://github.com/containous/traefik/releases/download/v$TRAEFIK_VERSION/traefik_linux-$arch"; \
	chmod +x /usr/local/bin/traefik

COPY ./traefik.toml /etc/traefik/traefik.toml

ENV TRAEFIK_CONFIG /etc/traefik/traefik.toml

# Install supervisor and copy default config

RUN apk --no-cache add supervisor
COPY supervisord.ini /etc/supervisor.d/supervisord.ini

# Gunicorn environment values

COPY ./gunicorn_conf.py /gunicorn_conf.py

ENV APP_MODULE main:app

ENV GUNICORN_CONF /gunicorn_conf.py

ENV WORKERS_PER_CORE 2

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Copy sample flask app
COPY ./app /app
WORKDIR /app

EXPOSE 80 8081

ENTRYPOINT ["sh", "/entrypoint.sh"]

# Start Supervisor, which in turn will start Traefik and Gunicorn
CMD ["/usr/bin/supervisord"]