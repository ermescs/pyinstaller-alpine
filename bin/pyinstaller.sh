#!/bin/sh
# Simple wrapper around pyinstaller

set -e

# Use the hacked ldd to fix libc.musl-x86_64.so.1 location
PATH="/pyinstaller:$PATH"

# If CMD starts with an option, assume it's a pyinstaller option
if [ "${1:0:1}" = '-' ]; then
    set -- pyinstaller "$@"
fi

if [ "$1" = "pyinstaller" ]; then
    shift

    # Generate a random key for encryption
    random_key=$(pwgen -s 16 1)
    pyinstaller_args="${@/--random-key/--key $random_key}"

    if [ -f requirements.txt ]; then
        pip install -r requirements.txt
    elif [ -f setup.py ]; then
        pip install .
    fi

    # Exclude pycrypto and PyInstaller from built packages
    exec pyinstaller \
        --exclude-module pycrypto \
        --exclude-module PyInstaller \
        ${pyinstaller_args}
fi

exec "$@"
