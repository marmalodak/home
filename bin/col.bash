#!/usr/bin/env bash

set +x
set -e
set -u

min=0x00
max=0x20
colour=0x00

while [[ 1 ]]; do
    while [[ ${colour} -le ${max} ]] ; do
        colour=$((${colour}+1))
        xsetroot -solid $(printf "#%02x%02x%02x" ${colour} ${colour} ${colour})
        sleep 0.1s
    done

    while [[ ${colour} -gt ${min} ]] ; do
        colour=$((${colour}-1))
        xsetroot -solid $(printf "#%02x%02x%02x" ${colour} ${colour} ${colour})
        sleep 0.1s
    done
done
