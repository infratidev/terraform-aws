####################################################
# S3 Bucket tfstate infracost
####################################################

resource "aws_s3_bucket" "tf_state_infracost" {
  bucket = "infrati-tfstate-infracost"
  force_destroy = true

  tags = {
    Name        = "terraform-state-infracost"
    Environment = "Development"
  }
}

####################################################
# S3 Bucket ACL infracost
####################################################

resource "aws_s3_bucket_acl" "bucket_acl_tfstate_infracost" {
  bucket = aws_s3_bucket.tf_state_infracost.id
  acl    = "private"
}

####################################################
# Define Bucket Encryption
####################################################

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state_infracost" {
  bucket = aws_s3_bucket.tf_state_infracost.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

####################################################
# Enable S3 Bucket Versioning
####################################################

resource "aws_s3_bucket_versioning" "tf_state_infracost" {
  bucket = aws_s3_bucket.tf_state_infracost.id
  versioning_configuration {
    status = "Enabled"
  }
}