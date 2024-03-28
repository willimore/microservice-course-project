terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.41.0"
    }
  }

  backend "s3" {
    bucket  = "course-project-terraform-states"
    encrypt = true
    key     = "terraform/eks/terraform.tfstate"
    region  = "us-east-2"
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      owner = "pafable"
    }
  }
}

variable "region" {
  description = "aws region"
  default     = "us-east-1"
}