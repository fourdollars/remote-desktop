# syntax=docker/dockerfile:1.4
FROM ubuntu:noble
ENV DEBIAN_FRONTEND=noninteractive
RUN <<EOF
apt-get -q -q update
apt-get full-upgrade --yes
apt-get install --yes ubuntu-desktop-minimal gnome-remote-desktop
EOF
RUN <<EOF
cd /var/lib/gnome-remote-desktop
mkdir -p .local/share/gnome-remote-desktop/certificates .cache/gnome-remote-desktop
cat > .local/share/gnome-remote-desktop/grd.conf <<END
[RDP]
tls-key=/var/lib/gnome-remote-desktop/.local/share/gnome-remote-desktop/certificates/rdp-tls.key
tls-cert=/var/lib/gnome-remote-desktop/.local/share/gnome-remote-desktop/certificates/rdp-tls.crt
enabled=true
END
cat > .local/share/gnome-remote-desktop/credentials.ini <<END
[RDP]
credentials={'username': <'u'>, 'password': <'p'>}
END
openssl genrsa -out .local/share/gnome-remote-desktop/certificates/rdp-tls.key 4096
openssl req -subj "/CN=https:\/\/hackmd.io\/@fourdollars\/gnome-remote-desktop" -new -x509 -days 365 -key .local/share/gnome-remote-desktop/certificates/rdp-tls.key -out .local/share/gnome-remote-desktop/certificates/rdp-tls.crt
chown gnome-remote-desktop:gnome-remote-desktop -R .local .cache
chmod 600 .local/share/gnome-remote-desktop/certificates/rdp-tls.key .local/share/gnome-remote-desktop/certificates/rdp-tls.crt .local/share/gnome-remote-desktop/credentials.ini
EOF
ENTRYPOINT ["/lib/systemd/systemd"]
