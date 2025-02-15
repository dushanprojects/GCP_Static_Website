#!/bin/bash

DIR=$( pwd )
ENV=$1
ACTION=$2

function show_usage {
   echo "Error: Usage ./bin/deploy.sh [Environment] [plan|apply|destroy]"
   echo "Example ./bin/deploy.sh development plan"
}

function apply {
    cd $DIR/terraform/stacks/$ENV/
    rm -rf .terraform .terraform.lock.hcl
    ln -sf $DIR/secrets/$ENV/tf_backend.tf ./tf_backend.tf
    ln -sf $DIR/secrets/$ENV/terraform.auto.tfvars ./terraform.auto.tfvars
    export GOOGLE_APPLICATION_CREDENTIALS=$DIR/secrets/$ENV/gcp_sa_cred.json # Set default credential for GS state
    terraform --version | grep `cat .tfenv-version` # Make sure to use repository defined TF version (tfenv)
    terraform init
    terraform --version
    terraform apply
}

function plan {
    cd $DIR/terraform/stacks/$ENV/
    rm -rf .terraform .terraform.lock.hcl
    ln -sf $DIR/secrets/$ENV/tf_backend.tf ./tf_backend.tf
    ln -sf $DIR/secrets/$ENV/terraform.auto.tfvars ./terraform.auto.tfvars
    export GOOGLE_APPLICATION_CREDENTIALS=$DIR/secrets/$ENV/gcp_sa_cred.json # Set default credential for GS state
    terraform --version | grep `cat .tfenv-version` # Make sure to use repository defined TF version (tfenv)
    terraform init
    terraform plan
}

function destroy {
    cd $DIR/terraform/stacks/$ENV/
    rm -rf .terraform .terraform.lock.hcl
    ln -sf $DIR/secrets/$ENV/tf_backend.tf ./tf_backend.tf
    ln -sf $DIR/secrets/$ENV/terraform.auto.tfvars ./terraform.auto.tfvars
    export GOOGLE_APPLICATION_CREDENTIALS=$DIR/secrets/$ENV/gcp_sa_cred.json # Set default credential for GS state
    terraform --version | grep `cat .tfenv-version` # Make sure to use repository defined TF version (tfenv)
    terraform init
    terraform destroy
}

function execute {
    [[ $ACTION == "plan" ]] && plan
    [[ $ACTION == "apply" ]] && apply
    [[ $ACTION == "destroy" ]] && destroy
}

[[ "$#" -ne 2 ]] && show_usage

execute $ENV $ACTION