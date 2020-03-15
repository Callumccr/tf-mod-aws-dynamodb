## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| hash\_key | (Optional) - DynamoDB table Hash Key | `string` | n/a | yes |
| attributes | (Optional) - Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| autoscale\_max\_read\_capacity | (Optional) - DynamoDB autoscaling max read capacity | `number` | `20` | no |
| autoscale\_max\_write\_capacity | (Optional) - DynamoDB autoscaling max write capacity | `number` | `20` | no |
| autoscale\_min\_read\_capacity | (Optional) - DynamoDB autoscaling min read capacity | `number` | `5` | no |
| autoscale\_min\_write\_capacity | (Optional) - DynamoDB autoscaling min write capacity | `number` | `5` | no |
| autoscale\_read\_target | (Optional) - The target value (in %) for DynamoDB read autoscaling | `number` | `50` | no |
| autoscale\_write\_target | (Optional) - The target value (in %) for DynamoDB write autoscaling | `number` | `50` | no |
| aws\_account\_id | The AWS account id of the provider being deployed to (e.g. 12345678). Autoloaded from account.tfvars | `string` | `""` | no |
| aws\_assume\_role\_arn | (Optional) - ARN of the IAM role when optionally connecting to AWS via assumed role. Autoloaded from account.tfvars. | `string` | `""` | no |
| aws\_assume\_role\_external\_id | (Optional) - The external ID to use when making the AssumeRole call. | `string` | `""` | no |
| aws\_assume\_role\_session\_name | (Optional) - The session name to use when making the AssumeRole call. | `string` | `""` | no |
| aws\_region | The AWS region (e.g. ap-southeast-2). Autoloaded from region.tfvars. | `string` | `""` | no |
| billing\_mode | (Optional) - DynamoDB Billing mode. Can be PROVISIONED or PAY\_PER\_REQUEST | `string` | `"PROVISIONED"` | no |
| delimiter | (Optional) - Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes` | `string` | `"-"` | no |
| dynamo\_table\_names | (Optional) - The list of Dynamo tables to be created | `list(string)` | `[]` | no |
| dynamodb\_attributes | (Optional) - Additional DynamoDB attributes in the form of a list of mapped values | <code><pre>list(object({<br>    name = string<br>    type = string<br>  }))<br></pre></code> | `[]` | no |
| enable\_autoscaler | (Optional) - Flag to enable/disable DynamoDB autoscaling | `bool` | `true` | no |
| enable\_encryption | (Optional) - Enable DynamoDB server-side encryption | `bool` | `true` | no |
| enable\_point\_in\_time\_recovery | (Optional) - Enable DynamoDB point in time recovery | `bool` | `true` | no |
| enable\_streams | (Optional) - Enable DynamoDB streams | `bool` | `false` | no |
| enabled | (Optional) - A Switch that decides whether to create a terraform resource or run a provisioner. Default is true | `bool` | `true` | no |
| environment | (Optional) - Environment, e.g. 'dev', 'qa', 'staging', 'prod' | `string` | `""` | no |
| global\_secondary\_index\_map | (Optional) - Additional global secondary indexes in the form of a list of mapped values | <code><pre>list(object({<br>    hash_key           = string<br>    name               = string<br>    non_key_attributes = list(string)<br>    projection_type    = string<br>    range_key          = string<br>    read_capacity      = number<br>    write_capacity     = number<br>  }))<br></pre></code> | `[]` | no |
| hash\_key\_type | (Optional) - Hash Key type, which must be a scalar type: `S`, `N`, or `B` for (S)tring, (N)umber or (B)inary data | `string` | `"S"` | no |
| local\_secondary\_index\_map | (Optional) - Additional local secondary indexes in the form of a list of mapped values | <code><pre>list(object({<br>    name               = string<br>    non_key_attributes = list(string)<br>    projection_type    = string<br>    range_key          = string<br>  }))<br></pre></code> | `[]` | no |
| name | (Optional) - Solution name, e.g. 'vault', 'consul', 'keycloak', 'k8s', or 'baseline' | `string` | `""` | no |
| namespace | (Optional) - Namespace, which could be your abbreviated product team, e.g. 'rci', 'mi', 'hp', or 'core' | `string` | `""` | no |
| range\_key | (Optional) - DynamoDB table Range Key | `string` | `""` | no |
| range\_key\_type | (Optional) - Range Key type, which must be a scalar type: `S`, `N`, or `B` for (S)tring, (N)umber or (B)inary data | `string` | `"S"` | no |
| stream\_view\_type | (Optional) - When an item in the table is modified, what information is written to the stream | `string` | `""` | no |
| tags | (Optional) - Additional tags | `map(string)` | `{}` | no |
| ttl\_attribute | (Optional) - DynamoDB table TTL attribute | `string` | `"Expires"` | no |

## Outputs

| Name | Description |
|------|-------------|
| table\_arn | DynamoDB table ARNs |
| table\_id | DynamoDB table IDs |
| table\_name | DynamoDB table name names |
| table\_stream\_arn | The ARN of the Table Stream. Only available when stream\_enabled = true |

