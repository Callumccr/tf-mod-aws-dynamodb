# -----------------------------------------------------------------------------
# Variables: Common AWS Provider - Autoloaded from Terragrunt
# -----------------------------------------------------------------------------

variable "aws_region" {
  description = "The AWS region (e.g. ap-southeast-2). Autoloaded from region.tfvars."
  type        = string
  default     = ""
}

variable "aws_account_id" {
  description = "The AWS account id of the provider being deployed to (e.g. 12345678). Autoloaded from account.tfvars"
  type        = string
  default     = ""
}

variable "aws_assume_role_arn" {
  description = "ARN of the IAM role when optionally connecting to AWS via assumed role. Autoloaded from account.tfvars."
  type        = string
  default     = ""
}

# -----------------------------------------------------------------------------
# Variables: TF-MOD-DYANMO - https://github.com/aciem-admin/tf-mod-dynamo
# -----------------------------------------------------------------------------

variable "enabled" {
  description = "(Optional). A Switch that decides whether to create a terraform resource or run a provisioner. Default is true"
  type        = bool
  default     = true
}

variable "dynamo_tables" {
  type        = list(string)
  description = "The list of Dynamo tables to be created"
  default     = []
}


variable "autoscale_write_target" {
  type        = number
  default     = 50
  description = "The target value (in %) for DynamoDB write autoscaling"
}

variable "autoscale_read_target" {
  type        = number
  default     = 50
  description = "The target value (in %) for DynamoDB read autoscaling"
}

variable "autoscale_min_read_capacity" {
  type        = number
  default     = 5
  description = "DynamoDB autoscaling min read capacity"
}

variable "autoscale_max_read_capacity" {
  type        = number
  default     = 20
  description = "DynamoDB autoscaling max read capacity"
}

variable "autoscale_min_write_capacity" {
  type        = number
  default     = 5
  description = "DynamoDB autoscaling min write capacity"
}

variable "autoscale_max_write_capacity" {
  type        = number
  default     = 20
  description = "DynamoDB autoscaling max write capacity"
}

variable "billing_mode" {
  type        = string
  default     = "PROVISIONED"
  description = "DynamoDB Billing mode. Can be PROVISIONED or PAY_PER_REQUEST"
}

variable "enable_streams" {
  type        = bool
  default     = false
  description = "Enable DynamoDB streams"
}

variable "stream_view_type" {
  type        = string
  default     = ""
  description = "When an item in the table is modified, what information is written to the stream"
}

variable "enable_encryption" {
  type        = bool
  default     = true
  description = "Enable DynamoDB server-side encryption"
}

variable "enable_point_in_time_recovery" {
  type        = bool
  default     = true
  description = "Enable DynamoDB point in time recovery"
}

variable "hash_key" {
  type        = string
  description = "DynamoDB table Hash Key"
}

variable "hash_key_type" {
  type        = string
  default     = "S"
  description = "Hash Key type, which must be a scalar type: `S`, `N`, or `B` for (S)tring, (N)umber or (B)inary data"
}

variable "range_key" {
  type        = string
  default     = ""
  description = "DynamoDB table Range Key"
}

variable "range_key_type" {
  type        = string
  default     = "S"
  description = "Range Key type, which must be a scalar type: `S`, `N`, or `B` for (S)tring, (N)umber or (B)inary data"
}

variable "ttl_attribute" {
  type        = string
  default     = "Expires"
  description = "DynamoDB table TTL attribute"
}

variable "enable_autoscaler" {
  type        = string
  default     = "true"
  description = "Flag to enable/disable DynamoDB autoscaling"
}

variable "dynamodb_attributes" {
  type = list(object({
    name = string
    type = string
  }))
  default     = []
  description = "Additional DynamoDB attributes in the form of a list of mapped values"
}

variable "global_secondary_index_map" {
  type = list(object({
    hash_key           = string
    name               = string
    non_key_attributes = list(string)
    projection_type    = string
    range_key          = string
    read_capacity      = number
    write_capacity     = number
  }))
  default     = []
  description = "Additional global secondary indexes in the form of a list of mapped values"
}

variable "local_secondary_index_map" {
  type = list(object({
    name               = string
    non_key_attributes = list(string)
    projection_type    = string
    range_key          = string
  }))
  default     = []
  description = "Additional local secondary indexes in the form of a list of mapped values"
}

# -----------------------------------------------------------------------------
# Variables: TF-MOD-LABEL - https://github.com/aciem-admin/tf-mod-label
# -----------------------------------------------------------------------------

variable "namespace" {
  type        = string
  default     = ""
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
}

variable "name" {
  type        = string
  default     = ""
  description = "Solution name, e.g. 'app' or 'jenkins'"
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}


variable "context" {
  type = object({
    namespace           = string
    environment         = string
    stage               = string
    name                = string
    enabled             = bool
    delimiter           = string
    attributes          = list(string)
    label_order         = list(string)
    tags                = map(string)
    additional_tag_map  = map(string)
    regex_replace_chars = string
  })
  default = {
    namespace           = ""
    environment         = ""
    stage               = ""
    name                = ""
    enabled             = true
    delimiter           = ""
    attributes          = []
    label_order         = []
    tags                = {}
    additional_tag_map  = {}
    regex_replace_chars = ""
  }
  description = "Default context to use for passing state between label invocations"
}