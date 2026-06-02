provider "aws" {
  region = "us-east-1"
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
