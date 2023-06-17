
 #### Instance ami and instance type varible #######
 variable "ami_id" {
   type = string
   default         = "ami-04a0ae173da5807d3"
 }
 variable instance_type {
   type        = string
   default     = "t2.micro"
 }

 ####### Instance key pair to access the server ssh #####
 variable existing_key_pair {
   type        = string
   default     = "terraformkey2023"
   description = "existing key pair in aws console"
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
  type        = list
  default     = ["10.16.0.32/28", "10.16.0.64/28"]
  description = "blr_public_subnet"
}

###### IGW destination block ipaddr ######
variable dest_cidr_block {
  type        = string
  default     = "0.0.0.0/0"
  description = "description"
}

####### AZ Varaible for both private & public subnet ########
variable blr_private_az {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
  description = "AZ for private subnet"
}
variable blr_public_az {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
  description = "AZ for public subnet"
}


