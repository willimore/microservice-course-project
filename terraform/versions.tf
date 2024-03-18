terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.41.0"
    }
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