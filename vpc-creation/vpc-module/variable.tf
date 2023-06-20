################## VPC Variable ###################
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

######## subnet Variable ############
variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
}


