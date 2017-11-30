FROM alpine:latest
MAINTAINER Anthony PELLETIER <contact@anthonypelletier.fr>

RUN apk add --no-cache \
		linux-headers \
		build-base \
		supervisor \
		nginx \
		python3-dev \
	&& pip3 install --no-cache-dir --upgrade \
		pip \
		uwsgi \
		django

ADD ./rootfs/ /
ADD ./src/ /opt/

RUN if [[ -s /opt/requirements.txt ]]; then pip3 install -r /opt/requirements.txt; fi \
	&& rm -rf /var/cache/* \
	&& rm -rf /root/.cache/* \
	&& rm -rf /tmp/*

WORKDIR /opt/

ENV PROJECT_NAME project

EXPOSE 80

CMD ["supervisord", "-c", "/etc/supervisord.conf"]