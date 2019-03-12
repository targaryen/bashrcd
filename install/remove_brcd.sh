#!/usr/bin/env bash
#BASHRCFILE="NOTBASHRC"

BASHRCFILE=${BASHRCFILE:-~/.bashrc}

uninstall_bashrcd() {
# delete
# sed '/BRCDIR START/,/BRCDIR END/ d' ${BASHRCFILE}
sed -i '/BRCDIR START/,/BRCDIR END/ d' ${BASHRCFILE}

}

uninstall_bashrcd