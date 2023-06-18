module "vpc" {
  source           = "./vpcmodule"
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  name             = "MyVPC"
}

module "public_subnet" {
  source                    = "./subnetmodule/subpublic"
  vpc_id                    = module.vpc.vpc_id
  cidr_blocks               = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones        = ["us-east-1b", "us-east-1c"]
  names                     = ["Public Subnet 1", "Public Subnet 2"]
  public_route_table_id     = module.public_route_table.route_table_id
}

module "private_subnet" {
  source                    = "./subnetmodule/subprivate"
  vpc_id                    = module.vpc.vpc_id
  cidr_blocks               = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones        = ["us-east-1b", "us-east-1c"]
  names                     = ["Private Subnet 1", "Private Subnet 2"]
  private_route_table_id    = module.private_route_table.route_table_id
}
module "public_route_table" {
  source        = "./routetablemodule/routepublic"
  vpc_id        = module.vpc.vpc_id
  gateway_id    = module.igw.igw_id
  name          = "Public Route Table"
}

module "private_route_table" {
  source        = "./routetablemodule/routeprivate"
  vpc_id        = module.vpc.vpc_id
  name          = "Private Route Table"
}

module "igw" {
  source        = "./igwmodule"
  vpc_id        = module.vpc.vpc_id
  name          = "MyIGW"
}