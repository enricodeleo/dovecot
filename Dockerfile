FROM alpine:3.19

RUN apk update && \
    apk add dovecot dovecot-pigeonhole-plugin && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /var/lib/dovecot && \
    chmod 777 /var/lib/dovecot

COPY config/conf.d/10-logging.conf /etc/dovecot/conf.d/10-logging.conf

EXPOSE 143/tcp
EXPOSE 993/tcp

CMD ["/usr/sbin/dovecot", "-F"]
