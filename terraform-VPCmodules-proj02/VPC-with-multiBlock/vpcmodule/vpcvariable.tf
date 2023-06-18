variable "cidr_block" {
  description = "CIDR block for the VPC"
}

variable "instance_tenancy" {
  description = "Instance tenancy for the VPC"
  default     = "default"
}

variable "name" {
  description = "Name tag for the VPC"
}