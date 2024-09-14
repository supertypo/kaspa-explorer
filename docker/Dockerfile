##
# builder image
##
FROM node:18-alpine AS builder

ARG REPO_DIR
ARG TAG

RUN apk --no-cache add \
  git

COPY . /build

ENV REACT_APP_VERCEL_GIT_COMMIT_SHA="$TAG"

RUN cd /build \
  && npm install


##
# runtime image
##
FROM node:18-alpine

EXPOSE 8080

ENV API_URI=http://localhost:8000 \
  API_WS_URI=ws://localhost:8001

RUN apk --no-cache add \
  dumb-init

COPY docker/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod 755 /docker-entrypoint.sh

RUN addgroup -S -g 55748 kaspa-explorer \
  && adduser -h /app -S -D -g '' -G kaspa-explorer -u 55748 kaspa-explorer

WORKDIR /app
USER kaspa-explorer

COPY --from=builder --chown=kaspa-explorer:kaspa-explorer /build/*.js /app/
COPY --from=builder --chown=kaspa-explorer:kaspa-explorer /build/build /app/build
COPY --from=builder --chown=kaspa-explorer:kaspa-explorer /build/node_modules /app/node_modules

ARG VERSION
ARG COMMIT_ID

ENV VERSION=$VERSION \
  COMMIT_ID=$COMMIT_ID

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD node server.js
