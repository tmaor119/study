terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region  = var.aws_region
}

data "aws_availability_zones" "available" {
  exclude_names = ["ap-northeast-2b", "ap-northeast-2d"]
}

provider "http" {}