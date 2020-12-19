#!/usr/bin/python3

import sys
while True:
    inp = sys.stdin.buffer.read(27)
    if not inp:
        # raise ValueError("input empty")
        sys.exit()
    if len(inp) != 27:
        raise ValueError(f"incorrect len {len(inp)}")
    print("".join(f"{b:02x}" for b in inp), flush=True)
