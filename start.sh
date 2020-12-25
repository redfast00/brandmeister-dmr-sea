#!/bin/bash
docker run -it --rm --mount type=bind,source="$(pwd)"/shared,target=/app/shared --mount type=bind,source="$(pwd)"/config/config.json,target=/app/config.json,readonly brandmeister-dmr-sea
