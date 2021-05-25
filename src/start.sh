#!/bin/bash
set -euo pipefail


if [[ ! -p /tmp/dmr.fifo ]]; then
  mkfifo /tmp/dmr.fifo
fi

if [[ ! -p /tmp/audio.fifo ]]; then
  mkfifo /tmp/audio.fifo
fi

ruby ruby-client.rb &
sleep 3

./pipeline.sh &
./callrec
