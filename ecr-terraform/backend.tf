terraform {
     backend "s3" {
    bucket = "aluruarumullaa20"
    key    = "ecr/terraform.tfstate"
    region = "us-east-1"
  }
}