provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../.."

  name     = "example-complete"
  vpc_cidr = "10.20.0.0/16"

  public_subnets = {
    public_a = {
      cidr_block        = "10.20.1.0/24"
      availability_zone = "us-east-1a"
      tags = {
        Workload = "web"
      }
    }
    public_b = {
      cidr_block        = "10.20.2.0/24"
      availability_zone = "us-east-1b"
      tags = {
        Workload = "web"
      }
    }
  }

  create_security_group = true

  security_group_ingress_rules = [
    {
      description = "HTTPS from anywhere"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Environment = "dev"
    Owner       = "platform-engineering"
    CostCenter  = "demo"
  }
}
