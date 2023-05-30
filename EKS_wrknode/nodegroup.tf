
resource "aws_eks_node_group" "my_node_group" {
  cluster_name    = eks-clusterctrlplane01
  node_group_name = my_node_group
  node_role_arn   = aws_iam_role.my_node_group_role.arn
  subnet_ids      = module.eks_vpc.workernode_subnet_ids
  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  # Add other necessary configuration
}
resource "aws_iam_role" "my_node_group_role" {
  name = "my-node-group-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}
resource "aws_iam_role_policy_attachment" "my_node_group_role_attachment" {
  role       = aws_iam_role.my_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "cni_policy_attachment" {
  role       = aws_iam_role.my_node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}
# Define the VPC module
module "eks_vpc" {
  source = "../EKS_VPC/"  # Replace with the path to your VPC module folder
  # Additional input variables required by your VPC module
}