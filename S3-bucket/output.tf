output "bucket1" {

  description = "ID of the first bucket"
  value = aws_s3_bucket.bucket1.id
}

output "bucket2" {

  description = "ID of the second bucket"
  value = aws_s3_bucket.bucket2.id
}