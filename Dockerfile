FROM alpine:3.15

# Set timezone
RUN apk add --no-cache tzdata bash
ENV TZ Europe/London

WORKDIR /etc/periodic

COPY backup_configure.sh daily/backup_configure
RUN chmod a+x daily/backup_configure

CMD ["crond", "-l",  "1", "-f", "-S"]

