# VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-vpc"
  cidr = var.vpc_cidr
 
  azs             = data.aws_availability_zones.azs.names
  #private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = var.public_subnets

  #enable_nat_gateway = true / internetgate/routable/routable associate every think automatically create this module
  #enable_vpn_gateway = true
  enable_dns_hostnames = true

  tags = {
    Name = "jenkins-VPC"
    Terraform = "true"
    Environment = "dev"
  }
}

# SG

# EC2