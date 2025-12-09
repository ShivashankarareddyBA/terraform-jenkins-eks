terraform {
  backend "s3" {
    bucket = "name of the bucket which we have created in the aws s3 bucket name"
    key = "eks/terraform.tfstate"
    region = "ap-south-1"
  }
}