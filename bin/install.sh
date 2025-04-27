#!/usr/bin/env bash

# check for override of base directory for install, e.g.: INSTALL_BASE=$HOME/.local
if [ -z "${INSTALL_BASE:-}" ]; then
  INSTALL_BASE=/usr/local
fi

if [ ! -w ${INSTALL_BASE} ]; then
    echo "user ${USER} does not have write access to ${INSTALL_BASE}"
    echo "perhaps you meant to use \`sudo\` or define \`INSTALL_BASE\` for a local installation?"
    exit 1
fi
echo "This will install zwift.sh into $INSTALL_BASE/bin"
read -p "Press enter to continue"

mkdir -p $INSTALL_BASE/bin
curl -s -o $INSTALL_BASE/bin/zwift https://raw.githubusercontent.com/netbrain/zwift/master/zwift.sh
chmod u=rwx,go=rx $INSTALL_BASE/bin/zwift

mkdir -p $INSTALL_BASE/share/icons/hicolor/scalable/apps
curl -s -o $INSTALL_BASE/share/icons/hicolor/scalable/apps/zwift.svg https://raw.githubusercontent.com/netbrain/zwift/master/assets/hicolor/scalable/apps/Zwift%20Logogram.svg

mkdir -p $INSTALL_BASE/share/applications
curl -s -o $INSTALL_BASE/share/applications/Zwift.desktop https://raw.githubusercontent.com/netbrain/zwift/master/assets/Zwift.desktop


if [ "$(echo $PATH | grep $INSTALL_BASE/bin)" = "" ]; then
    echo "WARNING: Could not find $INSTALL_BASE/bin on the \$PATH, you might need to add it."
fi
