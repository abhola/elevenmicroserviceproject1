terraform {
     backend "s3" {
    bucket = "aluruarumullaa2"
    key    = "ecr/terraform.tfstate"
    region = "us-east-1"
  }
}