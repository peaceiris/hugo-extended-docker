#!/bin/sh

case "$1" in
    "server" | "serve")
        shift
        eval hugo server --bind 0.0.0.0 "$*"
        ;;
    *)
        eval hugo "$*"
        ;;
esac
