terraform {
  backend "s3" {
    bucket = "aluruarumullaa1985"
    key    = "ec2/terraform.tfstate"
    region = "us-east-1"
  }
}