FROM alpine:3.19

RUN apk update && \
    apk add --no-cache dovecot dovecot-pigeonhole-plugin su-exec && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /var/run/dovecot/login /var/lib/dovecot && \
    chmod -R 777 /var/run/dovecot /var/lib/dovecot

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY config/conf.d/10-logging.conf /etc/dovecot/conf.d/10-logging.conf

EXPOSE 143/tcp
EXPOSE 993/tcp

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/usr/sbin/dovecot", "-F", "-c", "/etc/dovecot/dovecot.conf"]
