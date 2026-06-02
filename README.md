# terraform-aws-vpc-platform

Production-style Terraform VPC module used as a portfolio project for cloud platform engineering.

This module demonstrates:

- Reusable Terraform module design
- PR validation with Terraform, TFLint, and Checkov
- Conventional commit / PR title enforcement
- Semantic version release automation
- Slack and Microsoft Teams release notifications
- Registry-friendly module structure

## Usage

```hcl
module "vpc" {
  source = "github.com/YOUR_GITHUB_USER/terraform-aws-vpc-platform?ref=v1.0.0"

  name     = "example"
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
```

## Release Process

This repository uses conventional commits and semantic-release.

| Change Type | Example | Version Bump |
|---|---|---|
| Fix | `fix: correct subnet output` | Patch |
| Feature | `feat: add flow log support` | Minor |
| Breaking Change | `feat!: rename subnet variable` | Major |
| Chore | `chore: update docs` | No release by default |

## Local Development

```bash
terraform fmt -recursive
terraform init -backend=false
terraform validate
tflint --init
tflint --recursive
checkov -d .
```

## Examples

- `examples/basic`
- `examples/complete`

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
