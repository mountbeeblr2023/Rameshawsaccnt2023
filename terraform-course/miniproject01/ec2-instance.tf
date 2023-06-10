### Creating 3 instance which having dev, qa, prod instance name & 3 diffrent Ami'ID and
####Instance type, Using variable type list as object and count function######
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
      ami_id         = "ami-026ebd4cfe2c043b2"  # Replace with your qa AMI ID
      instance_type  = "t2.medium"    # Replace with your qa instance type
    },
    {
      name           = "prod"
      ami_id         = "ami-053b0d53c279acc90"  # Replace with your prod AMI ID
      instance_type  = "t2.large"     # Replace with your prod instance type
    }
  ]

resource "aws_instance" "ec2_instances" {
  count = length(var.instances)

  ami           = var.instances[count.index].ami_id
  instance_type = var.instances[count.index].instance_type

  tags = {
    Name = var.instances[count.index].name
  }
}

locals {
  os_flavors = {
    "dev"  = "AMazon-Linux"   # Replace with the expected OS flavor for dev
    "qa"   = "RedHat-Linux" # Replace with the expected OS flavor for qa
    "prod" = "Ubuntu-Linux"   # Replace with the expected OS flavor for prod
  }
}

provisioner "local-exec" {
    command = <<-EOT
      os_flavor=$(aws ec2 describe-images --image-ids ${self.ami} --query 'Images[0].Description' --output text | awk '{print tolower($0)}')
      expected_flavor="${local.os_flavors[self.tags.Name]}"
      if [[ "$os_flavor" != *"$expected_flavor"* ]]; then
        echo "AMI ID '${self.ami}' for '${self.tags.Name}' does not match the expected OS flavor ('$expected_flavor')"
        exit 1
      fi
    EOT
  }
}