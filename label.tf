module "dynamo_label" {
  source              = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.14.1"
  context             = var.context
  delimiter           = "-"
  attributes          = ["dyn"]
  additional_tag_map  = {} /* Additional attributes (e.g. 1) */
}

