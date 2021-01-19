#!/bin/bash
# script to install PinfiniTV
# tynick.com

GIT_URL='https://github.com/tynick/PinfiniTV.git'
INSTALL_PATH='/root/PinfiniTV'

header ()
{
    message=$1
    separate='###############################################'
    echo -e "\n${separate}"
    echo -e "${message}"
    echo -e "${separate}\n"
}

# make sure we are running as root user
header "checking user"
if [ "$EUID" -ne 0 ]; then 
  echo "Script must be run as root. Exiting."
  exit 1
fi

# update and install dependencies
header "installing packages and dependencies"
apt-get update -y && apt-get install -y git omxplayer || exit 1

# clone PinfiniTV repository
header "clone PinfiniTV repository"
git clone "${GIT_URL}" "${INSTALL_PATH}" || exit 1

# change to directory of cloned repo
header "change to PinfiniTV directory"
cd "${INSTALL_PATH}" || exit 1

# add cron.d entry
header "adding entry to cron.d entry"
echo '@reboot root /root/PinfiniTV/run.sh' > /etc/cron.d/pinfinitv || exit 1

# reboot
echo -e "\n\nRebooting Raspberry Pi in 10 seconds. Videos should begin auto playing when it boots back up."
sleep 10
reboot
