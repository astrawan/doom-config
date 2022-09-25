#!/bin/bash

gpg -dq --no-tty --for-your-eyes-only "$1" | awk " \$2==\"$2\" && \$6==\"$3\" && \$4==\"$4\"{print \$8;}"
