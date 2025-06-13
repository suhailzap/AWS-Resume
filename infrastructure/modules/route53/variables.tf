variable "domain_name" {
  description = "Domain name for the Route53 zone"
  type        = string
}

variable "cloudfront_domain_name" {
  description = "Domain name of the CloudFront distribution"
  type        = string
}

variable "cloudfront_zone_id" {
  description = "Hosted zone ID of the CloudFront distribution"
  type        = string
}

variable "certificate_validation_options" {
  description = "Certificate validation options for ACM certificate"
  type = list(object({
    domain_name           = string
    resource_record_name  = string
    resource_record_value = string
    resource_record_type  = string
  }))
} 