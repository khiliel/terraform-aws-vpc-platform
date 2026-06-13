terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 7.0"
    }
  }
}


module "vpc" {
  source = "../.."

  name     = "example-basic"
  vpc_cidr = "10.10.0.0/16"

  public_subnets = {
    public_a = {
      cidr_block        = "10.10.1.0/24"
      availability_zone = "us-east-1a"
    }
  }

  tags = {
    Environment = "dev"
    Owner       = "platform-engineering"
  }
}
