#!/usr/bin/env sh
set -e

# Explicitly add installed Python packages
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.7/site-packages:/usr/lib/python3.7/site-packages

exec "$@"