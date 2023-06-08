resource "aws_instance" "testserver01" {
  ami           = "ami-0715c1897453cabd1"  # Update with your desired AMI ID
  instance_type = "t2.micro"                # Update with your desired instance type

  tags = {
    app = "meemo"
    tier = "dev"
  }
}