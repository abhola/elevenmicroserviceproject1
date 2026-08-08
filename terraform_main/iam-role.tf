resource "aws_iam_role" "iam-role" {
  name               = var.iam-role
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
resource "aws_iam_role_policy" "terraform_s3_backend" {
  name = "TerraformS3BackendAccess"
  role = aws_iam_role.iam-role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket"
      ],
      "Resource": "arn:aws:s3:::aluruarumullaa2985"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      "Resource": "arn:aws:s3:::aluruarumullaa2985/eks/*"
    }
  ]
}
EOF
}

######## Terrafom plan job fail because that role currently doesn't have permission to read VPC information. we used data "aws_vpc" "main" {" ###
resource "aws_iam_role_policy" "jumphost_ec2_read" {
  name = "JumphostEC2ReadAccess"
  role = "Jumphost-iam-role1"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeVpcs"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}