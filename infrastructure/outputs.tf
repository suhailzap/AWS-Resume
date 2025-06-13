output "website_url" {
  description = "URL of the website"
  value       = "https://${var.domain_name}"
}

output "cloudfront_domain" {
  description = "Domain name of the CloudFront distribution"
  value       = module.cloudfront.domain_name
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.s3.bucket_id
}

output "api_endpoint" {
  description = "API Gateway endpoint URL"
  value       = module.lambda.api_endpoint
}

output "name_servers" {
  description = "Name servers for the domain"
  value       = module.route53.name_servers
} 