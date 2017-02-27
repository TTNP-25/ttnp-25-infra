#!/bin/bash
source ~/.ttnp25
export TF_VAR_ttn_ssh_pub_key=$HOME/.ssh/ttn.pub
export TF_VAR_github_token=$(cat ~/.ttnp-25.gh)
terraform $1
