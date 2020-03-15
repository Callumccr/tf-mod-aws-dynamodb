# -----------------------------------------------------------------------------
# Outputs: TF-MOD-DYANMO 
# -----------------------------------------------------------------------------

output "table_name" {
  value       = formatlist("%s", aws_dynamodb_table.default.*.name)
  description = "DynamoDB table name names"
}

output "table_id" {
  value       = formatlist("%s", aws_dynamodb_table.default.*.id)
  description = "DynamoDB table IDs"
}

output "table_arn" {
  value       = formatlist("%s", aws_dynamodb_table.default.*.arn)
  description = "DynamoDB table ARNs"
}

output "table_stream_arn" {
  value       = formatlist("%s", aws_dynamodb_table.default.*.stream_arn)
  description = "The ARN of the Table Stream. Only available when stream_enabled = true"
}