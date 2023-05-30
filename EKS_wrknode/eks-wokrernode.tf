resource "aws_launch_configuration" "wrknode_launch_config" {
  name          = "wrknode_launch_config"
  image_id      = "ami-1234567890abcdef0"  # Specify the appropriate AMI ID
  instance_type = "t2.micro"     # Specify the desired instance type
  iam_instance_profile = "aws_iam_instance_profile.my_instance_profile.name"
  security_groups      = [module.eks_vpc.workernode_security_group_ids]

  # Add other necessary configuration
}

resource "aws_autoscaling_group" "eks_wrk_asg01" {
  name                      = "auto_asg01"
  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 2
  launch_configuration      = aws_launch_configuration.wrknode_launch_config.name
  vpc_zone_identifier       = module.eks_vpc.workernode_subnet_ids  # Specify the subnet IDs in which the worker nodes should be placed

  # Add other necessary configuration
}

# Define the VPC module
module "eks_vpc" {
  source = "../EKS_VPC/"  # Replace with the path to your VPC module folder
  # Additional input variables required by your VPC module
}