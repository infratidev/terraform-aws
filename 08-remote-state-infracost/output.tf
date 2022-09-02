#############################################
# Bucket Arn
#############################################

output "s3_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
  value       = aws_s3_bucket.tf_state_infracost.arn
}

#############################################
# Bucket Domain Name
#############################################

output "s3_bucket_bucket_domain_name" {
  description = "The bucket domain name"
  value       = aws_s3_bucket.tf_state_infracost.bucket_domain_name
}

#############################################
# Role Arn
#############################################

output "role_arn" {
  value = aws_iam_role.github_actions.arn
}