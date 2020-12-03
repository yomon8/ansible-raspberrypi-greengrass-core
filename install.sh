#!/bin/bash
set -eu 
SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd ${SCRIPT_DIR}

WORK_DIR=/home/pi/work

# Select installation type 
menu=$(ls -1 ./ggc_*.yml)
echo "select playbook:"
select playbook in $menu
do
  if [ "${REPLY}" = "q" ]; then
    echo "QUIT."
    exit -1
  fi

  if [ -n "${playbook}" ]; then
    if [ "${playbook}" = "./ggc_apt.yml" ]; then
        GG_GROUP_NAME="DUMMY"
        GG_CORE_NAME="DUMMY"
        AWS_REGION="DUMMY"
        AWS_ACCESS_KEY_ID="DUMMY"
        AWS_SECRET_ACCESS_KEY="DUMMY"
        AWS_SESSION_TOKEN="DUMMY"
    fi
    break
  else
    echo "invalid selection."
  fi
done
AWS_REGION=${AWS_REGION}
AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}
GG_GROUP_NAME=${GG_GROUP_NAME}
GG_CORE_NAME=${GG_CORE_NAME}

# Get Raspberry IP Address
regex_ip="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
printf "Raspberry Pi IP: "
read RPI_IP
if [[ ! ${RPI_IP} =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]];then 
echo "Invalid IP !"
fi


ansible-playbook $* -i ${RPI_IP}, ${playbook}  \
    -e work_dir=${WORK_DIR} \
    -e aws_access_key=${AWS_ACCESS_KEY_ID} \
    -e aws_secret_access_key=${AWS_SECRET_ACCESS_KEY} \
    -e aws_session_token=${AWS_SESSION_TOKEN} \
    -e aws_region=${AWS_REGION} \
    -e gg_group_name=${GG_GROUP_NAME} \
    -e gg_core_name=${GG_CORE_NAME}

cd -
