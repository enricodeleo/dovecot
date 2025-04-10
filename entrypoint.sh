#!/bin/sh
set -e

# Valori di default per UID e GID
USER_UID=${USER_UID:-1000}
USER_GID=${USER_GID:-1000}

# Creazione del gruppo dovecotgroup con GID specificato, se non esiste
if ! getent group dovecotgroup >/dev/null; then
    addgroup -g "$USER_GID" dovecotgroup
fi

# Creazione dell'utente dovecotuser con UID e GID specificati, se non esiste
if ! getent passwd dovecotuser >/dev/null; then
    adduser -D -u "$USER_UID" -G dovecotgroup dovecotuser
fi

# Impostazione dei permessi per /var/lib/dovecot e /mail
chown -R dovecotuser:dovecotgroup /var/lib/dovecot /mail

# Esecuzione del comando come dovecotuser
exec su-exec dovecotuser "$@"
