# Create the EKS cluster
resource "aws_eks_cluster" "eks_ctrlplane01" {
  name     = "eks-clusterctrlplane01"
  role_arn = "arn:aws:iam::301770107409:role/EKS-ctrl-plane-role01"
  version  = "1.24"  # Replace with the desired EKS version
  vpc_config {
    subnet_ids              = module.eks_vpc.EKS_subnet_ids
    security_group_ids      = module.eks_vpc.EKS_security_group_ids
    endpoint_private_access = true
    endpoint_public_access  = false
  }
}  

# Define the VPC module
module "eks_vpc" {
  source = "../EKS_VPC/"  # Replace with the path to your VPC module folder
  # Additional input variables required by your VPC module
}
output "eksctrlplane_deatils" {
  value = [aws_eks_cluster.eks_ctrlplane01.name]
}