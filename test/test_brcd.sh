#!/usr/bin/env bash

BASHRCFILE=${BASHRCFILE:-~/.bashrc}

TMP_ORIGINAL="tmp_orig"
TMP_MODIFIED="tmp_modified"
TMP_INSTALLED="tmp_installed"

copy_original(){
cp ${BASHRCFILE} ${TMP_ORIGINAL}
cp ${BASHRCFILE} ${TMP_MODIFIED}

}


copy_original

export BASHRCFILE=${TMP_MODIFIED}

echo "Copying original bashrc, performing install and uninstall to validate against this to establish idempotence"

echo "--------------------START INSTALL NOTBASHRC---------------"
../install/install_brcd.sh
echo "--------------------END NOTBASHRC---------------"

echo "Install finished"

#echo "READING"
#echo "--------------------START READ NOTBASHRC---------------"
#cat NOTBASHRC
#echo "--------------------END READ NOTBASHRC---------------"

cp ${BASHRCFILE} ${TMP_INSTALLED}

echo "REMOVING"

echo "--------------------START REMOVE NOTBASHRC---------------"
../install/remove_brcd.sh
echo "--------------------END REMOVE NOTBASHRC---------------"


echo "Diffing.."
echo "Compare original to install and removed"
diff ${TMP_ORIGINAL} ${TMP_MODIFIED}

if [ $(diff ${TMP_ORIGINAL} ${TMP_MODIFIED} | wc -l) -eq 0 ]; then
  echo "No change."
fi

echo "Compare original to installed"
diff ${TMP_ORIGINAL} ${TMP_INSTALLED}


if [ $(diff ${TMP_ORIGINAL} ${TMP_INSTALLED} | wc -l) -eq 0 ]; then
  echo "No change."
fi

