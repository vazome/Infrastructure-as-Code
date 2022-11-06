terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.23.0"
    }
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region
}

data "aws_vpc" "selected" {}

resource "aws_default_security_group" "default" {
  vpc_id = data.aws_vpc.selected.id
}

