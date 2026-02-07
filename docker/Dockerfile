##
# builder image
##
FROM node:18-alpine AS builder

ARG REPO_DIR=.
ARG VERSION

RUN apk --no-cache add \
  git

COPY "$REPO_DIR" /build

ENV REACT_APP_VERCEL_GIT_COMMIT_SHA="$VERSION"

RUN cd /build && npm install && npm run build

##
# runtime image
##
FROM node:18-alpine

EXPOSE 8080

RUN apk --no-cache add dumb-init

WORKDIR /app

COPY --from=builder --chown=55748:55748 /build/*.js ./
COPY --from=builder --chown=55748:55748 /build/build ./build
COPY --from=builder --chown=55748:55748 /build/node_modules ./node_modules

COPY docker/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod 755 /docker-entrypoint.sh

USER 55748

ARG VERSION
ENV VERSION=$VERSION

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["node", "server.js"]
