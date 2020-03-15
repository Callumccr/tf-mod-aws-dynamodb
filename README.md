<!-- 














  ** DO NOT EDIT THIS FILE
  ** 
  ** This file was automatically generated by the `build-harness`. 
  ** 1) Make all changes to `README.yaml` 
  ** 2) Run `make init` (you only need to do this once)
  ** 3) Run`make readme` to rebuild this file. 
  **
  ** (We maintain HUNDREDS of open source projects. This is how we maintain our sanity.)
  **















  -->

#

[![README Header][logo]][website]

# tf-mod-aws-dynamodb

## Module description


Use the `tf-mod-aws-dynamodb` Terraform module to provision a DynamoDB table with autoscaling.

The autoscaler scales up/down the provisioned OPS for the DynamoDB table based on the load.

## Requirements
This module requires [AWS Provider](https://github.com/terraform-providers/terraform-provider-aws) `>= 1.17.0`




Project: **[%!s(<nil>)](%!s(<nil>))** : [[%!s(<nil>)](%!s(<nil>))] | [[%!s(<nil>)](%!s(<nil>))] 




## Introduction

The `tf-mod-aws-dynamodb` module will create:
* Dynamo table
* Autoscaling functionality for read/write



## Usage

**IMPORTANT:** The `master` branch is used in `source` just as an example. In your code, do not pin to `master` because there may be breaking changes between releases.
Instead pin to the release tag (e.g. `?ref=tags/x.y.z`) of one of our [latest releases](https://github.com/https://github.com/Callumccr/tf-mod-aws-dynamodb/releases).


The below values shown in the usage of this module are purely representative, please replace desired values as required.

```hcl
module "dynamodb_table" {
  source                       = "git::https://github.com/callumccr/terraform-aws-dynamodb.git?ref=master"
  namespace                    = "eg"
  stage                        = "dev"
  name                         = "cluster"
  hash_key                     = "HashKey"
  range_key                    = "RangeKey"
  autoscale_write_target       = 50
  autoscale_read_target        = 50
  autoscale_min_read_capacity  = 5
  autoscale_max_read_capacity  = 20
  autoscale_min_write_capacity = 5
  autoscale_max_write_capacity = 20
  enable_autoscaler            = true
}
```





## Examples
Simple and advanced examples of this project.

### Advanced Example 1:

Some advanced examples of the unmodified upstream provider of this module can be found here(https://github.com/cloudposse/terraform-aws-dynamodb)

TO-DO

  ```hcl
  ```


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




## Related Projects

You can find more [Terraform Modules](terraform_modules) by vising the link.

Additionally, check out these other related, and maintained projects.

- [%!s(<nil>)](%!s(<nil>)) - %!s(<nil>)



## References

For additional context, refer to some of these links. 

- [cloudposse/terraform-aws-dynamodb](https://github.com/cloudposse/terraform-aws-dynamodb) - Unmodified upstream provided for this module



## Help

**Got a question?** We got answers. 

File a Github [issue](https://github.com/Callumccr/tf-mod-aws-dynamodb/issues), or message us on [Slack][slack]


### Contributors

|  [![Callum Robertson][callumccr_avatar]][callumccr_homepage]<br/>[Callum Robertson][callumccr_homepage] |
|---|


  [callumccr_homepage]: https://www.linkedin.com/in/callum-robertson-1a55b6110/

  [callumccr_avatar]: https://media-exp1.licdn.com/dms/image/C5603AQHb_3oZMZA5YA/profile-displayphoto-shrink_200_200/0?e=1588809600&v=beta&t=5QQQAlHrm1od5fQNZwdjOtbZWvsGcgNBqFRhZWgnPx4




---



---


[![README Footer][logo]][website]

  [logo]: https://wariva-github-assets.s3.eu-west-2.amazonaws.com/logo.png
  [website]: https://www.linkedin.com/company/52152765/admin/
  [github]: https://github.com/Callumccr
  [slack]: https://wariva.slack.com
  [linkedin]: https://www.linkedin.com/in/callum-robertson-1a55b6110/
  [terraform_modules]: https://github.com/Callumccr