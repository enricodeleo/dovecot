#!/bin/sh
set -e

# Valori di default per UID e GID
USER_UID=${USER_UID:-1000}
USER_GID=${USER_GID:-1000}

# Controlla se è possibile modificare i permessi (ambiente rootless o no)
if touch /test_root_perms 2>/dev/null; then
    rm /test_root_perms

    # Creazione gruppo e utente solo se abbiamo i permessi
    if ! getent group dovecotgroup >/dev/null; then
        addgroup -g "$USER_GID" dovecotgroup
    fi

    if ! getent passwd dovecotuser >/dev/null; then
        adduser -D -u "$USER_UID" -G dovecotgroup dovecotuser
    fi

    # Modifica permessi
    chown -R dovecotuser:dovecotgroup /var/lib/dovecot /mail

    # Esecuzione come dovecotuser
    exec su-exec dovecotuser "$@"
else
    # Esegui direttamente in modalità rootless
    exec "$@"
fi