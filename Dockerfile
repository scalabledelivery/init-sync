FROM alpine:latest
WORKDIR /
COPY scripts/entrypoint.sh /bin/entrypoint
COPY scripts/daemon.sh /bin/daemon
COPY scripts/download.sh /bin/download
RUN chmod +x /bin/daemon /bin/download /bin/entrypoint
RUN apk add -U nmap-ncat openssl bash
ENV SYNC_PORT=1337
ENV DEBUG=0
ENTRYPOINT /bin/entrypoint