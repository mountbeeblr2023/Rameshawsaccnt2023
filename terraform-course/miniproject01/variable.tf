
#### Instance ami and instance type varible #######
variable "instances" {
  type = list(object({
    name           = string
    ami_id         = string
    instance_type  = string
  }))
  default = [
    {
      name           = "dev"
      ami_id         = "ami-04a0ae173da5807d3"  # Replace with your dev AMI ID
      instance_type  = "t2.micro"     # Replace with your dev instance type
    },
    {
      name           = "qa"
      ami_id         = "ami-04a0ae173da5807d3"  # Replace with your qa AMI ID
      instance_type  = "t2.micro"    # Replace with your qa instance type
    },
    {
      name           = "prod"
      ami_id         = "ami-04a0ae173da5807d3"  # Replace with your prod AMI ID
      instance_type  = "t2.micro"     # Replace with your prod instance type
    }
  ]
}

#### VPC Variables ####
variable blr_vpc {
  type        = string
  default     = "10.16.0.0/20"
  description = "CIDR address"
}

##### subnet Variables for private & public #######
variable blr_private_subnet {
  type        = list
  default     = ["10.16.0.0/28", "10.16.0.16/28"]
  description = "blr_private_subnet"
}
variable blr_public_subnet {
  type        = string
  default     = "10.16.0.32/28"
  description = "blr_public_subnet"
}

####### AZ Varaible for both private & public subnet ########
variable blr_private_az {
  type        = list
  default     = ["us-east-1a", "us-east-1b"]
  description = "AZ for private subnet"
}
variable blr_public_az {
  type        = string
  default     = "us-east-1c"
  description = "AZ for public subnet"
}


