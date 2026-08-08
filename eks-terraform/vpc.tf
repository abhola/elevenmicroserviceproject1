# ----------------------------
# VPC and Subnet Data Sources # data is used to pick the value from outside of terraform 
# ----------------------------
data "aws_vpc" "main" {
  tags = {
    Name = "Jumphost.vpc"
  }
}

data "aws_subnet" "subnet-1" {
  vpc_id = "subnet-0e0cbce33641830ac"
  filter {
    name   = "tag:Name"
    values = ["Public-Subnet1"]
  }
}

data "aws_subnet" "subnet-2" {
  vpc_id = "subnet-0c85f020c2ba40fe5"
  filter {
    name   = "tag:Name"
    values = ["Public-subnet2"]
  }
}

data "aws_security_group" "selected" {
  vpc_id = data.aws_vpc.main.id
  filter {
    name   = "tag:Name"
    values = ["Jumphost-sg"]
  }
} 
