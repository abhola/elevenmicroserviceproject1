resource "aws_vpc" "vpc" {
 cidr_block = "10.0.0.0/16"
 enable_dns_support = true
 enable_dns_hostnames = true 

 tags = {
   Name = var.vpc-name


 }   
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id 

    tags =  {
     Name = var.igw-name

    }
}

resource "aws_subnet" "public-subnet-1" {
   vpc_id = aws_vpc.vpc.id 
   cidr_block = "10.0.1.0/24"
   availability_zone = "us-east-1a"
   map_public_ip_on_launch = true

   tags = {
    Name = var.subnet-name1
   }
}


resource "aws_subnet" "public-subnet-2" {
   vpc_id = aws_vpc.vpc.id 
   cidr_block = "10.0.0.0/24"
   availability_zone = "us-east-1a"
   map_public_ip_on_launch = true

   tags = {
    Name = var.subnet-name2
   }
}

resource "aws_subnet" "private-subnet-1" {
   vpc_id = aws_vpc.vpc.id 
   cidr_block = "10.0.2.0/24"
   availability_zone = "us-east-1a"
   map_public_ip_on_launch = false

   tags =  {
    Name = var.private-subnet-1
   }
}


resource "aws_subnet" "private-subnet-2" {
   vpc_id = aws_vpc.vpc.id 
   cidr_block = "10.0.3.0/24"
   availability_zone = "us-east-1a"
   map_public_ip_on_launch = false

   tags = {
    Name = var.private-subnet-2
   }
}
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  } 
}

resource "aws_route_table_association" "rt-assocation" {
   route_table_id = aws_route_table.rt.id
   subnet_id = aws_subnet.public-subnet-1.id

}
resource "aws_route_table_association" "rt-assocation2" {
   route_table_id = aws_route_table.rt.id
   subnet_id = aws_subnet.public-subnet-2.id

}
 
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "NAT-EIP"
  }
}
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public-subnet-1.id

  tags = {
    Name = "NAT-Gateway"
  }

  depends_on = [
    aws_internet_gateway.igw
  ]
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  route {                                          //here we add route in same resource we can define seprate also 
     cidr_block = "0.0.0.0/0"                     // resource "aws_route" "private_nat_route" {          
     nat_gateway_id = aws_nat_gateway.nat_gw.id  //      route_table_id         = aws_route_table.private_rt.id
                                                //       destination_cidr_block = "0.0.0.0/0"
                                               // nat_gateway_id         = aws_nat_gateway.nat_gw.id
                                              //  }
  }
  tags = {
    Name = "Private-RT"
  }
}
resource "aws_route_table_association" "private_rt_association" {
   route_table_id = aws_route_table.private_rt.id
   subnet_id = aws_subnet.private-subnet-1.id

}

resource "aws_route_table_association" "private_rt_association2" {
   route_table_id = aws_route_table.private_rt.id
   subnet_id = aws_subnet.private-subnet-2.id

}

resource "aws_security_group" "security-group" {
    vpc_id = aws_vpc.vpc.id
    description = "Allowing Jenkins, Sonarqube, SSH Access"

   ingress = [
     for port in [22, 443, 8080, 9000, 9090, 3306, 80] : {
      description      = "TLS from VPC"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      ipv6_cidr_blocks = ["::/0"]
      self             = false
      prefix_list_ids  = []
      security_groups  = []
      cidr_blocks      = ["0.0.0.0/0"]
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg-name
  }
} 
