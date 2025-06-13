# AWS Resume Website

This project demonstrates a serverless resume website hosted on AWS infrastructure. The architecture includes:

- Amazon S3 for static website hosting
- CloudFront for content delivery
- Route 53 for DNS management
- AWS Certificate Manager for SSL
- Lambda & API Gateway for backend functionality
- DynamoDB for visitor tracking
- GitHub Actions for CI/CD

## Project Structure

```
.
├── README.md
├── infrastructure/        # Infrastructure as Code (Terraform)
├── src/                  # Source code
│   ├── frontend/        # HTML, CSS, JavaScript
│   └── backend/         # Lambda functions
└── .github/             # GitHub Actions workflows
```

## Setup Instructions

1. Clone this repository
2. Configure AWS credentials
3. Update domain settings in Route 53
4. Deploy infrastructure using Terraform
5. Push changes to trigger CI/CD pipeline

## Features

- Responsive design
- Visitor counter
- Contact form
- SSL encryption
- Global CDN distribution
- Automated deployments

## Cost Considerations

This project is designed to be cost-effective and can run within AWS Free Tier limits:
- S3: First 5GB storage free
- CloudFront: First 1TB data transfer free
- Lambda: First 1M requests/month free
- DynamoDB: 25GB storage free

## Security

- S3 bucket policies
- CloudFront Origin Access Control
- HTTPS enforcement
- IAM least privilege
- Access logging enabled 