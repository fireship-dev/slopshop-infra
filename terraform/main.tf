terraform {
  backend "s3" {
    bucket         = "slopshop-terraform-state"
    key            = "slopshop/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "slopshop-terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

locals {
  name_prefix = "${var.project}-${var.environment}"
  azs         = slice(data.aws_availability_zones.available.names, 0, var.az_count)

  is_prod    = var.environment == "prod"
  is_nonprod = !local.is_prod

  # NAT gateways: one per AZ when requested (staging/prod), otherwise a single shared one.
  nat_gateway_count = var.nat_gateway_per_az ? var.az_count : 1
}
