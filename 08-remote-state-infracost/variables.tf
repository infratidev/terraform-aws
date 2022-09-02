variable "region" {
    description = "Default region"
    default = "us-east-1"
}

variable "env" {
  description = "Environment"
  default     = "Infracost"
}

variable "client_id_list" {
  default = [
    "sts.amazonaws.com"
  ]
}

variable "repo_name" {
  default = "infratidev/terraform-infracost-aws-github-action-oidc"
}