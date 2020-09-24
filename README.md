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

export GG_GROUP_NAME=my-pi-grp
export GG_CORE_NAME=my-pi-core
export AWS_REGION=ap-northeast-1
```

run launcher script.

```sh
/bin/bash install.sh
Raspberry Pi IP: <input ip address of your Raspberry Pi>
SSH password: <input pi user password>
```

