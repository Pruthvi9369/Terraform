output "bucket_id" {
  description = "S3 bucket id"
  value = aws_s3_bucket.NewBucket.id
}

output "bucket_arn" {
  description = "S3 bucket arn"
  value = aws_s3_bucket.NewBucket.arn
}

output "bucket_domain_name" {
  description = "S3 bucker domain name"
  value = aws_s3_bucket.NewBucket.bucket_domain_name
}

output "bucket_hosted_zone_id" {
  description = "Bucket Hosted Zone Id"
  value = aws_s3_bucket.NewBucket.hosted_zone_id
}

output "bucker_region" {
  description = "Bucket Region"
  value = aws_s3_bucket.NewBucket.region
}

output "bucker_website_endpoint" {
  description = "Bucket website endpoint"
  value = aws_s3_bucket.NewBucket.website_endpoint
}

output "bucker_website_domain" {
  description = "Bucket website domain"
  value = aws_s3_bucket.NewBucket.website_domain
}
