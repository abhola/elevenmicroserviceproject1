resource "aws_s3_bucket" "bucket1" {
  bucket = "aluruarumullaa19"

  tags = {
    Name        = "My bucket1"
    Environment = "Dev"
  }
}
resource "aws_s3_bucket_versioning" "bucket1_versioning" {
  bucket = aws_s3_bucket.bucket1.id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket" "bucket2" {
  bucket = "aluruarumullaa20"

  tags = {
    Name        = "My bucket2"
    Environment = "Dev"
  }
}
resource "aws_s3_bucket_versioning" "bucket2_versioning" {
  bucket = aws_s3_bucket.bucket2.id
  versioning_configuration {
    status = "Enabled"
  }
}
