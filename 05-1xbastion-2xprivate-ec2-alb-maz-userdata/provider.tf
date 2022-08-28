terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.25.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  profile = "default"
}