variable "bucket1" {
 description = "Name of the first S3 bucket"
 type = string 
 default = "aluruarumullaa1111"

}

variable "bucket2" {
 description = "Name of the second S3 bucket"
 type = string 
 default = "aluruarumullaa2222"

}

variable "env" {
    description = "Environment tag for the bucket"
    type = string
    default = "dev"
}