#!/bin/bash

cl65 -t cx16 -C overlay.cfg src/main.s src/main.c src/overlay1.c src/overlay2.c src/overlay3.c -Ln overlay.sym -m overlay.map -o OVERLAY.PRG
