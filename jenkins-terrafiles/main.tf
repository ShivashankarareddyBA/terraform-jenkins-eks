# VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-vpc"
  cidr = var.vpc_cidr

  azs = data.aws_availability_zones.azs.names
  #private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets = var.public_subnets
  map_public_ip_on_launch = true

  #enable_nat_gateway = true / internetgate/routable/routable associate every think automatically create this module
  #enable_vpn_gateway = true
  enable_dns_hostnames = true

  tags = {
    Name        = "jenkins-VPC"
    Terraform   = "true"
    Environment = "dev"
  }
  public_subnet_tags = {
    Name : jenkins-Subnets
  }
   redshift_route_table_tags = {
     name ="jenkins-rt"
   }
}

# SG
module "vote_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "jenkins-sg"
  description = "Security group for jenkins server"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "HTTP"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "ssh"
      description = "HTTP"
      cidr_blocks = "0.0.0.0/0"
  }, ]
  egress_with_cidr_blocks = [
    {

      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_blocks = "0.0.0.0/0"

    }
  ]
  tags = {
    name = " Jenkins-sg"
  }

}

# EC2
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "jenkins-server"

  instance_type               = var.instance_type
  key_name                    = docker
  monitoring                  = true
  vpc_security_group_ids      = [module.sg.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  user_data                   = file("installations.sh")
  availability_zone           = data.aws_availability_zones.azs.name[0]

  tags = {
    name : "Jenkins-server"
    Terraform   = "true"
    Environment = "dev"
  }
}