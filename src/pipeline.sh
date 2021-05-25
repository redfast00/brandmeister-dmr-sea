#!/bin/bash
tail -n +1 -f /tmp/dmr.fifo \
 | stdbuf -o0 od -w27 -tx1 -Anone \
 | stdbuf -o0 tr -d ' ' \
 | python2 decode72to49.py \
 | python3 to_ambe_format_file.py \
 | qemu-arm md380-emu -d \
 | sox --buffer 256 -r 8000 -e signed-integer -L -b 16 -c 1 -t raw /dev/stdin -t raw -r 48000 /tmp/audio.fifo