#!/usr/bin/env python3
import sys
import os

with os.fdopen(sys.stdout.fileno(), "wb", closefd=False) as stdout:
    stdout.write(b'.amb')
    stdout.flush()
    for line in sys.stdin:
        stdout.write(b'\x00')
        stdout.write(bytes.fromhex(line))
        stdout.flush()