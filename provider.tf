terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

  }
}

provider "aws" {
  default_tags {
    tags = {
      Environment = "Test"
      Owner       = "James"
      Project     = "Terraform Learning"
    }
  }
  profile = "ter-1"
  region  = "ap-southeast-1"
}