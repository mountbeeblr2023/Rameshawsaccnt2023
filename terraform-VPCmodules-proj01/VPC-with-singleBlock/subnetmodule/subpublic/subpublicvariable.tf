variable "vpc_id" {
  description = "VPC ID"
}

variable "cidr_block" {
  description = "CIDR block for the public subnet"
}

variable "availability_zone" {
  description = "Availability Zone for the public subnet"
}

variable "name" {
  description = "Name tag for the public subnet"
}

variable "public_route_table_id" {
  description = "ID of the public route table"
}
