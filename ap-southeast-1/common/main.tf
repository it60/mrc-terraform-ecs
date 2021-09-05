terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "mrcit94-terraform-dev"
    key            = "ap-southeast-1/common/terraform.tfstate"
    region         =  "ap-southeast-1"
    dynamodb_table = "mrcit94-terraform-state-locks-dev"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}