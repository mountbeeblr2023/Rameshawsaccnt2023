variable multi-ami {
  type        = map
  default     = {
    Amazon-ami = "ami-04a0ae173da5807d3"
    RedHat-ami = "ami-026ebd4cfe2c043b2"
    Ubuntu-ami = "ami-053b0d53c279acc90"
  }
  description = "Diffrent flavors of ami's"
}

variable myinstancetype {
  type        = string
  default     = "t2.micro"
  description = "micro instance only"
}


