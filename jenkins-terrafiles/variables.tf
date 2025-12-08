variable "vpc_cidr" {
    description = "VPC_CIDR"
    type= "string"
  
}
variable "public_subnets" {
    description = "Subnets CIDR"
    type = list(string)
  
}