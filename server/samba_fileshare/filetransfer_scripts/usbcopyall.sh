#!/bin/bash

SRC="/mnt/filetransferusb"
DEST="/srv/samba/share"

cp -r "$SRC"/* "$DEST"

echo "files copied from $SRC to $DEST"
