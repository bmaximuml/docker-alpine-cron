FROM alpine

# Set timezone
RUN apk add --no-cache tzdata
ENV TZ Europe/London

ENTRYPOINT ["crond", "-l",  "1", "-f", "-S"]
