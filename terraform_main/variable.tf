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