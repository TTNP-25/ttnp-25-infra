#!/bin/bash
export TF_VAR_github_token=$(cat ~/.ttnp-25.gh)
terraform $1
