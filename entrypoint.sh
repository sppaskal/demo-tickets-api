#!/bin/bash
set -e

# Remove stale PID file
rm -f /rails/tmp/pids/server.pid

# Execute the container's command
exec "$@"