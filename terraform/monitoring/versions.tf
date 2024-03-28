terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.41.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.12.1"
    }
  }

  backend "s3" {
    bucket  = "course-project-terraform-states"
    encrypt = true
    key     = "terraform/monitoring/terraform.tfstate"
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

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.eks_cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks_cluster_auth.token
  }
}

variable "region" {
  description = "aws region"
  default     = "us-east-1"
}

data "aws_eks_cluster" "eks_cluster" {
  name = local.name
}

data "aws_eks_cluster_auth" "eks_cluster_auth" {
  name = local.cluster_name
}