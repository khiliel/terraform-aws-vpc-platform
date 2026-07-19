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
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0, < 7.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0, < 7.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route.public_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create_internet_gateway"></a> [create\_internet\_gateway](#input\_create\_internet\_gateway) | Whether to create an internet gateway and public route table. | `bool` | `true` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Whether to create a managed security group. | `bool` | `false` | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | Whether DNS hostnames are enabled in the VPC. | `bool` | `true` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | Whether DNS support is enabled in the VPC. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Name prefix used for VPC resources. | `string` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | Map of public subnet definitions. | <pre>map(object({<br/>    cidr_block              = string<br/>    availability_zone       = string<br/>    map_public_ip_on_launch = optional(bool, true)<br/>    tags                    = optional(map(string), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_security_group_egress_cidr_blocks"></a> [security\_group\_egress\_cidr\_blocks](#input\_security\_group\_egress\_cidr\_blocks) | CIDR blocks allowed for outbound security group traffic. | `list(string)` | `[]` | no |
| <a name="input_security_group_ingress_rules"></a> [security\_group\_ingress\_rules](#input\_security\_group\_ingress\_rules) | Ingress rules for the managed security group. | <pre>list(object({<br/>    description = string<br/>    from_port   = number<br/>    to_port     = number<br/>    protocol    = string<br/>    cidr_blocks = list(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to all supported resources. | `map(string)` | `{}` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the VPC. | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | ID of the internet gateway, if created. |
| <a name="output_public_route_table_id"></a> [public\_route\_table\_id](#output\_public\_route\_table\_id) | ID of the public route table, if created. |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | Map of public subnet names to subnet IDs. |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | ID of the managed security group, if created. |
| <a name="output_vpc_arn"></a> [vpc\_arn](#output\_vpc\_arn) | ARN of the VPC. |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | CIDR block of the VPC. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID of the VPC. |
<!-- END_TF_DOCS -->
