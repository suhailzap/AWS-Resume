output "lambda_function_arn" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.visitor_counter.arn
}

output "lambda_function_name" {
  description = "The name of the Lambda function"
  value       = aws_lambda_function.visitor_counter.function_name
}

output "api_endpoint" {
  description = "The API Gateway endpoint URL"
  value       = "${aws_apigatewayv2_api.api.api_endpoint}/${aws_apigatewayv2_stage.stage.name}"
}

output "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  value       = aws_dynamodb_table.visitor_counter.name
} 