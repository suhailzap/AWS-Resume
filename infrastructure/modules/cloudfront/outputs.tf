output "distribution_id" {
  description = "The identifier for the distribution"
  value       = aws_cloudfront_distribution.website.id
}

output "domain_name" {
  description = "The domain name of the distribution"
  value       = aws_cloudfront_distribution.website.domain_name
}

output "hosted_zone_id" {
  description = "The CloudFront Route 53 zone ID"
  value       = aws_cloudfront_distribution.website.hosted_zone_id
} 