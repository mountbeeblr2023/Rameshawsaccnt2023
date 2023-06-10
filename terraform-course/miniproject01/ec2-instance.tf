resource "aws_instance" "testserver01" {
  ami           = local.selected_ami
  instance_type = var.myinstancetype

  tags = {
    app = "meemo"
    tier = "dev"
    os = "RedHat-ami"
    Name = "testserver01"
  }
}
locals {
  selected_ami = lookup(var.multi-ami, "RedHat-ami", "default-ami-id")
}
