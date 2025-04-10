FROM alpine:3.19

RUN apk update && \
    apk add --no-cache dovecot dovecot-pigeonhole-plugin su-exec && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /var/lib/dovecot /mail && \
    chmod 770 /var/lib/dovecot /mail

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY config/conf.d/10-logging.conf /etc/dovecot/conf.d/10-logging.conf

EXPOSE 143/tcp
EXPOSE 993/tcp

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/usr/sbin/dovecot", "-F", "-c", "/etc/dovecot/dovecot.conf"]
