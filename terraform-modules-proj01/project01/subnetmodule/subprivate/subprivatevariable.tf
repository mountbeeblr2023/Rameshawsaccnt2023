variable "vpc_id" {
  description = "VPC ID"
}

variable "cidr_block" {
  description = "CIDR block for the private subnet"
}

variable "availability_zone" {
  description = "Availability Zone for the private subnet"
}

variable "name" {
  description = "Name tag for the private subnet"
}

variable "private_route_table_id" {
  description = "ID of the private route table"
}
