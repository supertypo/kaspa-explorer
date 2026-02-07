// Read from runtime config if available (injected by Docker), otherwise use defaults
const runtimeConfig = typeof window !== 'undefined' ? window.__RUNTIME_CONFIG__ : {};

let API_SERVER = runtimeConfig.API_SERVER
let SOCKET_SERVER = runtimeConfig.SOCKET_SERVER
let ADDRESS_PREFIX = runtimeConfig.ADDRESS_PREFIX
let KASPA_UNIT = runtimeConfig.KASPA_UNIT
let SUFFIX = runtimeConfig.SUFFIX

export { API_SERVER, SOCKET_SERVER, ADDRESS_PREFIX, KASPA_UNIT, SUFFIX }
