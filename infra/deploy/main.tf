terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.23.0"
    }
  }

  backend "s3" {
    bucket               = "rl-infra-stage-tf"
    key                  = "tf-state-deploy"
    workspace_key_prefix = "tf-state-deploy-env"
    region               = "eu-west-1"
    encrypt              = true
    dynamodb_table       = "rl-infra-stage-tf-lock"
  }
}

provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = {
      Project  = var.project
      Contact  = var.contact
      ManageBy = "Terraform/deploy"
    }
  }
}

locals {
  prefix = "${var.prefix}-${terraform.workspace}"
}

data "aws_region" "current" {}


