 module "ec2-config" {
     source = "./modules/ec2resource"   
 }
 module "secgroup-config" {
     source = "./modules/securitygroups"
 }
module "vpc-config" {
    source = "./modules/vpcmodule"
}