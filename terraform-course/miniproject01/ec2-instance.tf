resource "aws_instance" "testserver01" {
  ami           = var.aminame  # Update with your desired AMI ID
  instance_type = lookup(var.multi-ami, aws_instance.testserver01.tags["RedHat"])               # Update with your desired instance type

  tags = {
    app = "meemo"
    tier = "dev"
    os = "RedHat"
  }
}

