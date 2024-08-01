ARG JDK_IMAGE=amazoncorretto:21-alpine-jdk

# Build
FROM $JDK_IMAGE  AS builder

COPY . /usr/src/basex/

WORKDIR /usr/src/basex

## run build in /usr/src/basex then copy files for deployment into /srv/basex
RUN ./gradlew clean stage && \
    cp -r build/basex /srv/basex && \
    mkdir /srv/basex/data

# Note: /srv/basex/data folder can be persisted on a volume outside the container.

# Main image
FROM $JDK_IMAGE

COPY --from=builder  /srv /srv

RUN apk add --no-cache bash

RUN chown -R root:root /srv && \
    chmod -R 744 /srv

ENV PATH=$PATH:/srv/basex/bin

WORKDIR /srv/basex

# Configure BaseX job scheduler
RUN bin/basex startup/jobs.xq

# Secure the BaseX admin account
ARG BASEX_ADMIN_PASSWORD=Balisage24!
RUN bin/basex -c"alter password admin ${BASEX_ADMIN_PASSWORD}"

# JVM options e.g "-Xmx2048m "
# add-opens is for Java 8 to 11 compatibility
ENV BASEX_JVM="-Xmx2048m --add-opens java.base/java.net=ALL-UNNAMED --add-opens java.base/jdk.internal.loader=ALL-UNNAMED"

# 8080/tcp: HTTP set in jetty.xml
# 8443/tcp: HTTPS set in jetty.xml
# 1984/tcp: API
# 8984/tcp: HTTP
# 8985/tcp: HTTP stop
EXPOSE 8080 8443 1984 8984 8985 80

VOLUME ["/srv/basex/data"]

# Run BaseX HTTP server
CMD ["/srv/basex/bin/basexhttp"]
