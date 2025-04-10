#!/bin/sh
set -e

# Valori di default per UID e GID
USER_UID=${USER_UID:-1000}
USER_GID=${USER_GID:-1000}

# Crea utente IMAP (se non esiste)
if ! id -u dovecotuser >/dev/null 2>&1; then
    adduser -D -u "$USER_UID" -G dovecotgroup dovecotuser
fi

# Verifica se possiamo modificare i permessi
if touch /test_root_perms 2>/dev/null; then
    rm /test_root_perms

    # Modifica permessi delle directory
    chown -R dovecotuser:dovecotgroup /var/lib/dovecot /mail

    # Esegui come l'utente dovecotuser
    exec su-exec dovecotuser "$@"
else
    # Esegui direttamente in modalità rootless
    exec "$@"
fi
