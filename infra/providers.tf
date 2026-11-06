terraform {
  required_version = "1.10.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.80.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}