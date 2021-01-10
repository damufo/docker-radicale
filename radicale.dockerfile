FROM python:alpine
RUN apk --no-cache add git curl \
    && pip install --no-cache-dir radicale \
    # -p No error if exists; make parent directories as needed
    && mkdir -p /etc/radicale \
    && mkdir -p /var/lib/radicale/collections \
    && addgroup radicale \
    # -h DIR   Home directory
	# -s SHELL Login shell
	# -G GRP   Group
	# -D       Don't assign a password
	# -H       Don't create home directory
	&& adduser -h /var/lib/radicale -s /sbin/nologin -G radicale -D -H radicale \
    # -R Recurse
    # -h Affect symlinks instead of symlink targets
    # -P Don't traverse symlinks
    && chown -R -h -P radicale:radicale /var/lib/radicale
VOLUME ["/etc/radicale", "/var/lib/radicale/collections"]
EXPOSE 5232/tcp
USER radicale:radicale
ENTRYPOINT ["python", "-m", "radicale"]
# --fail          Fail silently (no output at all) on HTTP errors
# --location      Follow redirects
# --output <file> Write to file instead of stdout
# --show-error    Show error even when -s is used
# --silent        Silent mode
HEALTHCHECK --start-period=30s --interval=5m --timeout=10s --retries=3 \
    CMD curl --fail --location --output /dev/null --show-error --silent http://localhost:5232/ \
    || exit 1
