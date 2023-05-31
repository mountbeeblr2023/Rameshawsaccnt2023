# Define local variables to capture EKS VPC component IDs
locals {
  vpc_id            = aws_vpc.eks_vpc.id
  subnet_ids        = {
    "eks_subnet_a" = aws_subnet.eks_subnet_a.id,
    "eks_subnet_b" = aws_subnet.eks_subnet_b.id
  }
  security_group_id = aws_security_group.eks_cluster_sg.id
  nacl_id           = aws_network_acl.eks_nacl.id
}

# ...

# Retrieve VPC component values using locals
data "aws_vpc" "existing_vpc" {
  id = local.vpc_id
}

data "aws_subnet" "existing_subnet" {
  for_each = local.subnet_ids
  id       = each.value
}

# ...

# Define local variables to capture worker node VPC component IDs
locals {
  worker_vpc_id            = aws_vpc.worker_vpc.id
  worker_subnet_ids        = {
    "worker_subnet_a" = aws_subnet.worker_subnet_a.id,
    "worker_subnet_b" = aws_subnet.worker_subnet_b.id
  }
  worker_security_group_id = aws_security_group.worker-security-group.id
}

# ...

# Retrieve worker node VPC component values using locals
data "aws_vpc" "worker_existing_vpc" {
  id = local.worker_vpc_id
}

data "aws_subnet" "worker_existing_subnet" {
  for_each = local.worker_subnet_ids
  id       = each.value
}


# Define the data block to fetch the IAM role ARN
data "aws_iam_role" "EKS-worker-node-role01" {
  name = "EKS-worker-node-role01" # Replace with the actual IAM role name
}