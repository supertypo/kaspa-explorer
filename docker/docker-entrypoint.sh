#!/bin/sh
API_URIS="https://api.kaspa.org http://de4.kaspa.org:8100 http://de4.kaspa.org:8101"
API_WS_URIS="wss://api.kaspa.org ws://de4.kaspa.org:8101"

if [ ! -f /tmp/.API_REPLACED ]; then
  for apiUri in $API_URIS; do
    find /app/ -name node_modules -prune -o -type f -exec sed -i "s|$apiUri|${API_URI}|g" {} \;
  done
  for apiWsUri in $API_WS_URIS; do
    find /app/ -name node_modules -prune -o -type f -exec sed -i "s|$apiWsUri|${API_WS_URI}|g" {} \;
  done
  touch /tmp/.API_REPLACED
fi
exec /usr/bin/dumb-init -- "$@"

