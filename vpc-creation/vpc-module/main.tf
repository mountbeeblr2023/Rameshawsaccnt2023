######### VPC source ##########
module "vpc" {
  source      = "./vpc-module"
  vpc_name    = "prod"
  vpc_cidr    = "10.0.0.0/16"
}


module "subnets" {
  source                 = "./vpc-module"
  vpc_id                 = module.vpc.vpc_output
  subnet_name            = "prod"
  private_subnet_cidr    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  availability_zones     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
