#!/usr/bin/env bash

BACKUPDIR=${BACKUPDIR:-~/.backup}
BASHRCFILE=${BASHRCFILE:-~/.bashrc}
BRCDIR=${BRCDIR:-~/.bashrcd}

BACKUPFILE=${BACKUPFILE:-${BACKUPDIR}/bashrcd/bashrc.$(date +%Y%m%d%H%S)}

mkdir -p ${BACKUPDIR}/bashrcd
cp ${BASHRCFILE} ${BACKUPFILE}

check_bashrcd_installed(){
  echo
  echo "Checking if bashrcd is already installed to ${BASHRCFILE}"



    linecount=$(sed -n '/BRCDIR START/,/BRCDIR END/ p' ${BASHRCFILE} | wc -l)
    if [ $linecount -gt 0 ]; then
      echo
      echo "bashrcd has already been added to this system, aborting.."
      echo
      echo "These were the matching lines in ${BASHRCFILE} :"
      echo
      sed -n '/BRCDIR START/,/BRCDIR END/ p' ${BASHRCFILE}
      echo
      echo "You can run remove_bashrcd.sh to remove the above if local, or run from GitHub, eg:"
      echo
      echo     "curl -s https://raw.githubusercontent.com/targaryen/bashrcd/master/install/remove_brcd.sh | bash"
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
echo "Your original file is backed up at ${BACKUPFILE}"
echo
echo "You can reload your ${BASHRCFILE} with the following"
echo
echo "    . ${BASHRCFILE}"
echo

