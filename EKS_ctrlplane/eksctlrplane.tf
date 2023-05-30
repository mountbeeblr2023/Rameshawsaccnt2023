# Create the EKS cluster
resource "aws_eks_cluster" "eks_ctrlplane01" {
  name     = "eks-clusterctrlplane01"
  role_arn = "arn:aws:iam::301770107409:role/aws-service-role/eks.amazonaws.com/AWSServiceRoleForAmazonEKS"
  version  = "1.21"  # Replace with the desired EKS version
  vpc_config {
    subnet_ids              = module.vpc.subnet_ids
    security_group_ids      = [module.vpc.eks_cluster_sg.id]
    endpoint_private_access = true
    endpoint_public_access  = false
  }
}  

# Define the VPC module
module "vpc" {
  source = "../EKS_VPC/"  # Replace with the path to your VPC module folder
  # Additional input variables required by your VPC module
}