# variable "aminame" {
#   type        = string
#   default     = "ami-0715c1897453cabd1"
#   description = "useast region ami"
# }

variable multi-ami {
  type        = map
  default     = {
    Amazon-ami = "ami-04a0ae173da5807d3"
    RedHat-ami = "ami-026ebd4cfe2c043b2"
    Ubuntu-ami = "ami-053b0d53c279acc90"
  }
  description = "description"
}

variable myinstancetype {
  type        = string
  default     = "t2.micro"
  description = "micro instance only"
}


