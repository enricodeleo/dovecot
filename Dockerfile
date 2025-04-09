FROM alpine:3.16

# Installiamo Dovecot e plugin base, togliamo la cache dopo
RUN apk update && \
    apk add dovecot dovecot-pigeonhole-plugin && \
    rm -rf /var/cache/apk/*

# Logging su stderr per vedere subito i log col comando "podman logs"
COPY config/conf.d/10-logging.conf /etc/dovecot/conf.d/10-logging.conf

EXPOSE 143/tcp
EXPOSE 993/tcp

CMD ["/usr/sbin/dovecot", "-F"]

