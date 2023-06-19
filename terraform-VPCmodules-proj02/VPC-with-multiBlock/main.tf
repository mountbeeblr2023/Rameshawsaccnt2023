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
module "naclsmodule" {
  source = "./naclmodule"

  vpc_id = "your-vpc-id"
  nacl_count = 2

  nacls = [
    {
      name           = "nacl-1"
      subnets        = module.priv_sub-01.private_subnet_ids
      inbound_rules  = [
        {
          rule_number = 100
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          rule_action = "allow"
          cidr_block  = "0.0.0.0/0"
        },
        {
          rule_number = 101
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          rule_action = "allow"
          cidr_block  = "0.0.0.0/0"
        }
      ]
      outbound_rules = [
        {
          rule_number = 200
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          rule_action = "allow"
          cidr_block  = "0.0.0.0/0"
        }
      ]
    },
    {
      name           = "nacl-2"
      subnets        = module.priv_sub-01.private_subnet_ids
      inbound_rules  = [
        {
          rule_number = 100
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          rule_action = "allow"
          cidr_block  = "0.0.0.0/0"
        },
        {
          rule_number = 101
          from_port   = 3389
          to_port     = 3389
          protocol    = "tcp"
          rule_action = "allow"
          cidr_block  = "0.0.0.0/0"
        }
      ]
      outbound_rules = [
        {
          rule_number = 200
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          rule_action = "allow"
          cidr_block  = "0.0.0.0/0"
        }
      ]
    }
  ]
}

output "nacl_ids" {
  description = "List of IDs of the created NACL resources."
  value       = module.naclsmodule.nacl_ids
}

