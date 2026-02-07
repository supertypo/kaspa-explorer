#!/bin/sh
set -e

# Use environment variables with defaults
API_SERVER="${API_SERVER:-https://api.kaspa.org}"
SOCKET_SERVER="${SOCKET_SERVER:-wss://api.kaspa.org}"
ADDRESS_PREFIX="${ADDRESS_PREFIX:-kaspa:}"
KASPA_UNIT="${KASPA_UNIT:-KAS}"
SUFFIX="${SUFFIX:-DEV}"

CONFIG_FILE="/app/build/config.js"

# Only replace once per container lifecycle
if [ ! -f /tmp/.CONFIG_REPLACED ]; then
  
  if [ -f "$CONFIG_FILE" ]; then
    echo "Applying runtime configuration..."
    
    # Generate the runtime config file
    cat > "$CONFIG_FILE" << EOF
// Runtime configuration - injected by Docker entrypoint
window.__RUNTIME_CONFIG__ = {
  API_SERVER: "$API_SERVER",
  SOCKET_SERVER: "$SOCKET_SERVER",
  ADDRESS_PREFIX: "$ADDRESS_PREFIX",
  KASPA_UNIT: "$KASPA_UNIT",
  SUFFIX: "$SUFFIX"
};
EOF
    
    echo "Configuration applied:"
    echo "  API_SERVER: $API_SERVER"
    echo "  SOCKET_SERVER: $SOCKET_SERVER"
    echo "  ADDRESS_PREFIX: $ADDRESS_PREFIX"
    echo "  KASPA_UNIT: $KASPA_UNIT"
    echo "  SUFFIX: $SUFFIX"
    
    touch /tmp/.CONFIG_REPLACED
  else
    echo "Warning: $CONFIG_FILE not found, skipping configuration"
  fi
fi

exec /usr/bin/dumb-init -- "$@"
