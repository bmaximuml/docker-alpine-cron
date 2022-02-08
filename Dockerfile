#FROM python:3.10-alpine3.15
FROM alpine:3.15

# Set timezone
RUN apk add --no-cache tzdata bash
ENV TZ Europe/London

COPY backup_configure.sh /etc/periodic/daily/backup_configure
RUN chmod a+x /etc/periodic/daily/backup_configure

CMD ["crond", "-l",  "1", "-f", "-S"]

