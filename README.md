# Minimal Dovecot Docker Image

> Lightweight and secure Docker image for running Dovecot IMAP server, built for homelab and self-hosting scenarios.

## Features

- 📦 Based on Alpine Linux for minimal footprint
- ✉️ IMAP server (Dovecot)
- 🔒 Designed for rootless Podman and MicroOS environments
- 🐳 Compatible with Podman Compose
- 🔧 Custom configuration via bind-mounted volumes

## Usage

### Build

Clone the repository and build the image:

```bash
git clone https://github.com/your-user/your-repo.git
cd your-repo
podman build -t dovecot:latest .
```

### Run

With `podman-compose` (recommended for stack deployments):

```bash
podman-compose up -d
```

Or standalone:

```bash
podman run --rm \
  -v ./config:/etc/dovecot:Z \
  -v /var/lib/media/mail-gateway/mail:/mail:Z \
  -p 1143:143 -p 1993:993 \
  dovecot:latest \
  /usr/sbin/dovecot -F -c /etc/dovecot/dovecot.conf
```

### Configuration

- **Configuration files** are mounted from `./config`.
- Mail storage is mounted from `/var/lib/media/mail-gateway/mail`.

Minimal `dovecot.conf` example:

```conf
log_path = /dev/stderr
mail_location = maildir:/mail
disable_plaintext_auth = no
auth_mechanisms = plain login
userdb {
  driver = passwd-file
  args = /etc/dovecot/users
}
passdb {
  driver = passwd-file
  args = /etc/dovecot/users
}
```

Create the `users` file:

```bash
# Format: username:{plain}password
echo 'youruser:{plain}yourpassword' > ./config/users
```

### Ports

| Port | Description    |
| ---- | -------------- |
| 1143 | IMAP (non-SSL) |
| 1993 | IMAP over SSL  |

## Roadmap

- [x] Minimal functional image
- [ ] TLS support
- [ ] Sieve filters
- [ ] Healthchecks
