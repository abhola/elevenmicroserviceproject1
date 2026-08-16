terraform {
  backend "s3" {
    bucket = "aluruarumullaa20"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}