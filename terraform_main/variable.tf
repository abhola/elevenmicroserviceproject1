variable "vpc-name" {
  description = "vpc name for our jumphost"
   type = string 
   default = "Jumphost.vpc"
}

variable "igw-name" {
 description = "igw name"
 type = string 
 default = "Jumphost-igw"
}

variable "subnet-name1" {
  description = "public subnet1"
  type = string 
  default = "Public-subnet1"  

}

variable "subnet-name2" {
  description = "public subnet2"
  type = string 
  default = "Public-subnet2" 

}
variable "private-subnet-1" {
  description = "Private subnet2"
  type = string 
  default = "Private-subnet1"

}

variable "private-subnet-2" {
  description = "Private subnet2"
  type = string 
  default = "Private-subnet2"

}

variable "ami_id" {
 description = " AMi Id "
 type = string 
 default = "ami-0bdc7d025135d7b49"

}

variable "instance_type" {
  description = "instance name "
  type = string 
  default = "t2.large"

} 
variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = "virginia"
}

variable "iam-role" {
  description = "IAM Role for the Jumphost Server"
  type = string
  default = "Jumphost-iam-role1"
}

variable "sg-name" {
  description = "Security Group for our Jumphost server"
  type = string
  default = "Jumphost-sg"
}