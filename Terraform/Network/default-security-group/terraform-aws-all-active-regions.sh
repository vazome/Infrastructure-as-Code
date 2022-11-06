#!/bin/bash

# requires latest AWS CLI and Terraform CLI.

# the script accepts AWS profile paramenter -> ./terraform-aws-all-active-regions.sh {profile name}
## if non provided, it will ask you for an AWS profile
profile=$1

if [[ -n "$profile" ]]; then
    echo "Input received"
else
    read -p "AWS Profile: " profile
fi

#lets get every activated region on the account
regions=($(aws ec2 describe-regions --profile $profile --output text | awk -F ' ' '{print $4}'))

for region in $regions; do
    terraform plan -var region=$region -var profile=$profile
    #terraform apply -auto-approve -var region=$region -var profile=$profile #& with Ampersand at the end we can parrallel but should set -lock=false
done
