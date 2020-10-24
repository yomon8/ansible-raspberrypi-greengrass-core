# ansible-raspberrypi-greengrass-core
AWS Greengrass Core Setup for Raspberry Pi

# Prerequisites

Can access Raspbian via SSH with password authentication.

required packages.

- Ansible
- sshpass

# Usage

clone repository.

```sh
git clone https://github.com/yomon8/ansible-raspberrypi-greengrass-core.git
cd ansible-raspberrypi-greengrass-core
```


one-liner to get AWS tokens

```sh
aws sts get-session-token --query 'Credentials | {A:AccessKeyId,B:SecretAccessKey,C:SessionToken}' --output yaml | awk  'NR==1{print "export AWS_ACCESS_KEY_ID="$2} NR==2{print "export AWS_SECRET_ACCESS_KEY="$2} NR==3{print "export AWS_SESSION_TOKEN="$2}'
```

set required environment variables.

```sh
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
export AWS_SESSION_TOKEN=AQoDYXdzEJr1K...o5OytwEXAMPLE=
export AWS_REGION=ap-northeast-1

# only required by setup tool installation
export GG_GROUP_NAME=my-pi-grp
export GG_CORE_NAME=my-pi-core
```

run a launcher script.

```sh
/bin/bash install.sh
select playbook: # select yourt installation type 
1) ./ggc_setup_tool.yml # Install Greengrass and configure Greengrass Core on Raspberry Pi to connect  to GreenGrass Core on AWS Cloud (use setuptool)
2) ./ggc_apt.yml # Install Greengrass core on Raspberry Pi (use apt)
#? 2
Raspberry Pi IP: <input ip address of your Raspberry Pi>
SSH password: <input pi user password>
```

### SSH Configuration

If you want to change the SSH configuration, use `./ssh_config` .

### Option
Start Greengrass Core group deployment with aws cli.

```sh
gg_group_id=$(aws greengrass list-groups --region ${AWS_REGION} --query "Groups[?Name=='${GG_GROUP_NAME}'].Id" --output text)
gg_group_latest_version_id=$(aws greengrass list-groups --region ${AWS_REGION} --query "Groups[?Name=='${GG_GROUP_NAME}'].LatestVersion" --output text)
aws greengrass create-deployment --deployment-type NewDeployment --group-id ${gg_group_id} --group-version-id ${gg_group_latest_version_id}
```
