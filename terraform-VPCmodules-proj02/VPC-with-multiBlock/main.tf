module "vpc" {
  source           = "./vpcmodule"
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  name             = "MyVPC"
}

module "priv_sub-01" {
  source         = "./subnetmodule/privatesub"
  vpc_id         = module.vpc.vpc_id
  subnet_configs = [
    {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-1a"
      name              = "privateSubnet1"
    },
    {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "us-east-1b"
      name              = "privateSubnet2"
    },
    {
      cidr_block        = "10.0.3.0/24"
      availability_zone = "us-east-1c"
      name              = "privateSubnet3"
    }
  ]
}

module "public_sub-01" {
  source         = "./subnetmodule/publicsub"
  vpc_id         = module.vpc.vpc_id
  subnet_configs = [
    {
      cidr_block        = "10.0.4.0/24"
      availability_zone = "us-east-1e"
      name              = "publicSubnet1"
    },
    {
      cidr_block        = "10.0.5.0/24"
      availability_zone = "us-east-1f"
      name              = "publicSubnet2"
    },
    {
      cidr_block        = "10.0.6.0/24"
      availability_zone = "us-east-1d"
      name              = "publicSubnet3"
    }
  ]
}

output "privatesubnet_ids" {
    value = module.priv_sub-01.private-subnet_ids
 }
 output "publicsubnet_ids" {
    value = module.public_sub-01.public-subnet_ids
 }

############################### NACLS #########################
module "private_nacls" {
  source = "./naclmodule"

  vpc_id = aws_vpc.main.id
}

resource "aws_subnet_network_acl_association" "private_association" {
  subnet_id          = module.privatesubnet_ids
  network_acl_id     = module.private_nacls.nacl_id
}
