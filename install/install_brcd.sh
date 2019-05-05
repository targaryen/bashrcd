#!/usr/bin/env bash

BACKUPDIR=${BACKUPDIR:-~/.backup}
BASHRCFILE=${BASHRCFILE:-~/.bashrc}
BRCDIR=${BRCDIR:-~/.bashrcd}

BACKUPFILE=${BACKUPFILE:-${BACKUPDIR}/bashrcd/bashrc.$(date +%Y%m%d%H%S)}

bold=$(tput bold) # This could also be a color.
reset=$(tput sgr0)

mkdir -p ${BACKUPDIR}/bashrcd
cp ${BASHRCFILE} ${BACKUPFILE}

check_bashrcd_installed(){
  echo
  echo "Checking if bashrcd is already installed to ${bold}${BASHRCFILE}${reset}"



    linecount=$(sed -n '/BRCDIR START/,/BRCDIR END/ p' ${BASHRCFILE} | wc -l)
    if [ $linecount -gt 0 ]; then
      echo
      echo "bashrcd has already been added to this system, aborting.."
      echo
      echo "These were the matching lines in ${bold}${BASHRCFILE}${reset} :"
      echo
      sed -n '/BRCDIR START/,/BRCDIR END/ p' ${BASHRCFILE}
      echo
      echo "You can run remove_bashrcd.sh to remove the above if local, or run from GitHub, eg:"
      echo
      echo     "${bold} curl -s https://raw.githubusercontent.com/targaryen/bashrcd/master/install/remove_brcd.sh | bash ${reset}"
      echo
      echo "Aborting..."
      echo
      exit 1
    fi
}


install_bashrcd(){

    mkdir -p ${BRCDIR}

    cat <<EOF >> ${BASHRCFILE}
#----BRCDIR START
BRCDIR=\${BRCDIR:-~/.bashrcd}
if [ -d \${BRCDIR} ]; then
  for i in \${BRCDIR}/*
    do
      if test -f "\$i"
      then
         source \$i
      fi
  done
fi
#----BRCDIR END
EOF

curl -s https://raw.githubusercontent.com/targaryen/bashrcd/master/aliases/0010--ebrc -o ${BRCDIR}/0010--ebrc
curl -s https://raw.githubusercontent.com/targaryen/bashrcd/master/aliases/0010--lbrc -o ${BRCDIR}/0010--lbrc
curl -s https://raw.githubusercontent.com/targaryen/bashrcd/master/aliases/0010--rbrc -o ${BRCDIR}/0010--rbrc

}

check_bashrcd_installed

echo "Installing bashrcd to ${BASHRCFILE}"

install_bashrcd
echo "Install finished, added the following lines to your ${BASHRCFILE}  : "


sed -n '/BRCDIR START/,/BRCDIR END/ p' ${BASHRCFILE}

echo
echo "Your original bashrc file is backed up at ${BACKUPFILE}"
echo
echo "You can now use the new aliases ${bold}ebrc${reset}, ${bold}lbrc${reset}, and ${bold}rbrc${reset}.  Usage:"
echo
echo "  ${bold}ebrc${reset} [load order] ${bold}<bashrc entry name>${reset}  "
echo
echo "         Edits existing bashrc entry or creates a new one."
echo
echo "         The ${bold}load order${reset} is ${bold}optional${reset}.  Use this when you need to finely control load order,"
echo "         though it is generally better to make each bashrc entry idempotent.  Default is 100, smaller numbers are"
echo "         loaded first.  If use a value other than 100 then you should use it each edit."
echo
echo "  ${bold}lbrc${reset} [load order] ${bold}<bashrc entry name>${reset}  "
echo
echo "         Lists the bashrc entries and their load orders"
echo
echo "  ${bold}rbrc${reset} [load order] ${bold}<bashrc entry name>${reset}  "
echo
echo "         Removes existing bashrc entry."
echo
echo "         The ${bold}load order${reset} parameter is only necessary if using non-default load order (any number besides 100). "
echo "         You don't have to zero pad the load order number. Use ${bold}lbrc${reset} to see the load order and entry names."
echo
echo
echo "Reload your bashrc for the above aliases to take effect immediately (after which, it will automatically be reloaded "
echo "for you when you create/edit/remove a bashrc entry via the aliases):"
echo
echo "${bold}    . ${BASHRCFILE}${reset}"
echo
echo "Try ${bold}lbrc${reset} command to see what the above looks like.  Enjoy!"
echo


