FROM alpine:3.16

RUN apk update && \
    apk add dovecot dovecot-pigeonhole-plugin dovecot-tools && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /var/lib/dovecot && \
    chmod 777 /var/lib/dovecot

COPY config/conf.d/10-logging.conf /etc/dovecot/conf.d/10-logging.conf

EXPOSE 143/tcp
EXPOSE 993/tcp

ENTRYPOINT ["/usr/sbin/dovecot", "-F"]
