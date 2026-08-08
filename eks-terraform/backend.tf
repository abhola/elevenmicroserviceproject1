terraform {
  backend "s3" {
    bucket = "aluruarumullaa2985"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}