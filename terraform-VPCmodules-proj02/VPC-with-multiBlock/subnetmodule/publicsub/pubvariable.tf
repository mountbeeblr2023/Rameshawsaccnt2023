variable "vpc_id" {
  description = "VPC ID"
}

variable "subnet_configs" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
    name              = string
  }))
  description = "Subnet configurations"
}
