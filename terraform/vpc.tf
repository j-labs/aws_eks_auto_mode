# I went the least effort way and used the official module from the Terraform registry.
# This is the module supported by Anton Babenko and his modules are well maintained and well tested.
module "jlabs_eks_poc_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jlabs-eks-poc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false
  # single nat gateway is used to reduce costs of the PoC
  single_nat_gateway = true
}