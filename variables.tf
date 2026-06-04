variable "name" {
  description = "Name prefix used for VPC resources."
  type        = string

  validation {
    condition     = length(trimspace(var.name)) > 0
    error_message = "name must not be empty."
  }
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr must be a valid CIDR block."
  }
}

variable "enable_dns_hostnames" {
  description = "Whether DNS hostnames are enabled in the VPC."
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Whether DNS support is enabled in the VPC."
  type        = bool
  default     = true
}

variable "create_internet_gateway" {
  description = "Whether to create an internet gateway and public route table."
  type        = bool
  default     = true
}

variable "public_subnets" {
  description = "Map of public subnet definitions."
  type = map(object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = optional(bool, true)
    tags                    = optional(map(string), {})
  }))
  default = {}

  validation {
    condition = alltrue([
      for subnet in values(var.public_subnets) : can(cidrhost(subnet.cidr_block, 0))
    ])
    error_message = "Every public subnet cidr_block must be a valid CIDR block."
  }
}

variable "create_security_group" {
  description = "Whether to create a managed security group."
  type        = bool
  default     = false
}

variable "security_group_ingress_rules" {
  description = "Ingress rules for the managed security group."
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}

variable "security_group_egress_cidr_blocks" {
  description = "CIDR blocks allowed for outbound security group traffic."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags applied to all supported resources."
  type        = map(string)
  default     = {}
}
