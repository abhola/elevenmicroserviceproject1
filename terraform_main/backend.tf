terraform {
  backend "s3" {
    bucket = "aluruarumullaa19"
    key    = "ec2/terraform.tfstate"
    region = "us-east-1"
  }
}