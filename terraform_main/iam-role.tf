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
/*
Note: This is a generated HCL content from the JSON input which is based on the latest API version available.
To import the resource, please run the following command:
terraform import azapi_resource. ?api-version=TODO

Or add the below config:
import {
  id = "?api-version=TODO"
  to = azapi_resource.
}
*/

resource "azapi_resource" "" {
  type      = "@TODO"
  parent_id = "/subscriptions/$${var.subscriptionId}/resourceGroups/$${var.resourceGroupName}"
  name      = ""
  body = {
    Statement = [{
      Action   = ["s3:ListBucket"]
      Effect   = "Allow"
      Resource = "arn:aws:s3:::aluruarumullaa2985"
      }, {
      Action   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
      Effect   = "Allow"
      Resource = "arn:aws:s3:::aluruarumullaa2985/eks/*"
    }]
    Version = "2012-10-17"
  }
}
