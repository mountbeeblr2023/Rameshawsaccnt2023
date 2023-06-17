module "vpc" {
  source           = "./vpcmodule"
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  name             = "MyVPC"
}

module "public_subnet" {
  source                    = "./subnetmodule/subpublic"
  vpc_id                    = module.vpc.vpc_id
  count                     = length(var.public_subnet_cidr)
  cidr_block                = var.public_subnet_cidr
  availability_zone         = var.availability
  name                      = "Public Subnet"
  public_route_table_id     = module.public_route_table.route_table_id
}

module "private_subnet" {
  source                    = "./subnetmodule/subprivate"
  vpc_id                    = module.vpc.vpc_id
  count                     = length(var.private_subnet_cidr)
  cidr_block                = var.private_subnet_cidr
  availability_zone         = var.availability
  name                      = "Private Subnet"
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

# module "public_nacl" {
#   source        = "./modules/nacl/public"
#   vpc_id        = module.vpc.vpc_id
#   name          = "Public NACL"
# }

# module "private_nacl" {
#   source        = "./modules/nacl/private"
#   vpc_id        = module.vpc.vpc_id
#   name          = "Private NACL"
# }
