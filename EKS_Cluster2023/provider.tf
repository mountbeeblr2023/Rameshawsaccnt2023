provider "aws" {
  region = "us-east-1"  # Set your desired AWS region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}