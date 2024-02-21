#!/bin/sh

PROJECT_ID=$1
PROJECT_NUMBER=$2
EDITOR=$3

cd terraform

cd function_scripts

zip main.py.zip main.py requirements.txt

ls

cd ..

terraform init

terraform apply -auto-approve -input=false -var=projectID=$PROJECT_ID -var=projectNumber=$PROJECT_NUMBER -var=editor=$EDITOR

TERRAFORM_SUCCESS="$(terraform output -raw function_success)"
SUB="No outputs found"

if [[ "$TERRAFORM_SUCCESS" == *"$SUB"* ]]; then
  terraform destroy -auto-approve
  echo -e "\033[31m Error: Terraform did not create successfully. All resources that were created were destroyed. Please re-run script. If problem persists, recheck configuration and logs.\033[0m"
  exit 1
fi

cd ..
 
npm start