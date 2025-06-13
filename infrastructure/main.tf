provider "aws" {
  region = var.aws_region
}

# ACM Certificate
resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

# Certificate validation
resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

# S3 Module
module "s3" {
  source = "./modules/s3"

  bucket_name = var.bucket_name
  environment = var.environment
}

# CloudFront Module
module "cloudfront" {
  source = "./modules/cloudfront"

  origin_domain    = module.s3.website_endpoint
  origin_id        = "S3-${var.bucket_name}"
  domain_name      = var.domain_name
  certificate_arn  = aws_acm_certificate_validation.cert.certificate_arn
  price_class      = var.cloudfront_price_class
  environment      = var.environment
}

# Route53 Module
module "route53" {
  source = "./modules/route53"

  domain_name                    = var.domain_name
  cloudfront_domain_name         = module.cloudfront.domain_name
  cloudfront_zone_id            = module.cloudfront.hosted_zone_id
  certificate_validation_options = aws_acm_certificate.cert.domain_validation_options
}

# Lambda Module
module "lambda" {
  source = "./modules/lambda"

  filename      = "../src/backend/visitor-counter.zip"
  function_name = "visitor-counter"
  table_name    = "visitor-counter"
  api_name      = "resume-api"
  environment   = var.environment
} 