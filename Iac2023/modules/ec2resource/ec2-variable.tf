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
      name           = "prod"
      ami_id         = "ami-04a0ae173da5807d3"  # Replace with your prod AMI ID
      instance_type  = "t2.micro"     # Replace with your prod instance type
    }
  ]
}