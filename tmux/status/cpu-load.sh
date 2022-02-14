#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo $(vm_stat) | awk -f "$CURRENT_DIR/cpu-load-memory.awk"

uptime | awk 'BEGIN {ORS=""} {print $(NF-2), $(NF-1), $NF}'
