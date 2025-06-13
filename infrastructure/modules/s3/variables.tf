variable "bucket_name" {
  description = "Name of the S3 bucket for website hosting"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., prod, dev)"
  type        = string
  default     = "prod"
} 