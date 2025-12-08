terraform {
  backend "s3" {
    bucket = "we need to paste bucket name which we created in the aws"
    key ="jenkins/terraform.tfstate"
    region = "ap-south-1"
  }
}
# make sure to not use any variables here it is best recommended to add actual vales here