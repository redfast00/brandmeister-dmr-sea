#!/bin/bash
if [ $# -lt 4 ]; then
    >&2 echo "Needs arguments"
    exit 1
fi

SRCCALL="$1"
SRCID="$2"
DSTCALL="$3"
DSTID="$4"
DATE=$(date --iso-8601=seconds)

OUTFILE="/app/shared/${DATE}_${SRCCALL}_${SRCID}_${DSTCALL}_${DSTID}.wav"
echo "$OUTFILE"
TMPFILE="$(mktemp --suffix=.wav)"

cat - | stdbuf -o0 od -w27 -tx1 -Anone \
| stdbuf -o0 tr -d ' ' \
| python2 decode72to49.py \
| python3 to_ambe_format_file.py \
| qemu-arm md380-emu -d \
| sox --buffer 256 -r 8000 -e signed-integer -L -b 16 -c 1 -t raw /dev/stdin "${TMPFILE}"

mv "$TMPFILE" "$OUTFILE"
