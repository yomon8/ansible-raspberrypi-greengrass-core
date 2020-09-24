#!/bin/bash
set -eu 

regex_ip="^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"

printf "Raspberry Pi IP: "
read RPI_IP
if [[ ! ${RPI_IP} =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]];then 
echo "Invalid IP !"
fi

GG_GROUP_NAME=${GG_GROUP_NAME}
GG_CORE_NAME=${GG_CORE_NAME}
AWS_REGION=${AWS_REGION}
AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}

ansible-playbook $* -i ${RPI_IP}, main.yml  \
    -e work_dir=/home/pi/work \
    -e aws_access_key=${AWS_ACCESS_KEY_ID} \
    -e aws_secret_access_key=${AWS_SECRET_ACCESS_KEY} \
    -e aws_session_token=${AWS_SESSION_TOKEN} \
    -e aws_region=${AWS_REGION} \
    -e gg_group_name=${GG_GROUP_NAME} \
    -e gg_core_name=${GG_CORE_NAME}
