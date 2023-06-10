resource "aws_instance" "testserver01" {
  ami           = lookup(var.multi-ami, aws_instance.testserver01.tags["os"], "default-ami-id")
  instance_type = var.myinstancetype

  tags = {
    app = "meemo"
    tier = "dev"
    os = "RedHat"
    Name = "testserver01"
  }
}

