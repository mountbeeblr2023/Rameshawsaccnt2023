module "vpc" {
  source           = "./vpcmodule"
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  name             = "MyVPC"
}

module "subnets" {
  source         = "./subnetmodule/privatesub"
  vpc_id         = module.vpc.vpc_id
  subnet_configs = [
    {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "us-east-1a"
      name              = "Subnet 1"
    },
    {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "us-east-1b"
      name              = "Subnet 2"
    },
    {
      cidr_block        = "10.0.3.0/24"
      availability_zone = "us-east-1c"
      name              = "Subnet 3"
    }
  ]
}

output "subnet_ids" {
  value = module.subnets.subnet_ids
}
