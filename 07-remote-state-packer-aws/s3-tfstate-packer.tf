####################################################
# S3 Bucket tfstate packer network
####################################################

resource "aws_s3_bucket" "tf_state_packer_terraform" {
  bucket = "infrati-tfstate-packer-terraform"
  force_destroy = true

  tags = {
    Name        = "terraform-state-packer-terraform"
    Environment = "Development"
  }
}

####################################################
# S3 Bucket ACL Packer Network
####################################################

resource "aws_s3_bucket_acl" "bucket_acl_tfstate_packer_terraform" {
  bucket = aws_s3_bucket.tf_state_packer_terraform.id
  acl    = "private"
}

####################################################
# Define Bucket Encryption
####################################################

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state_packer_terraform" {
  bucket = aws_s3_bucket.tf_state_packer_terraform.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

####################################################
# Enable S3 Bucket Versioning
####################################################

resource "aws_s3_bucket_versioning" "tf_state_packer_terraform" {
  bucket = aws_s3_bucket.tf_state_packer_terraform.id
  versioning_configuration {
    status = "Enabled"
  }
}
