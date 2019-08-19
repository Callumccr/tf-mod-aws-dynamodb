module "dynamo_label" {
  source              = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.14.1"
  context             = var.context
  regex_replace_chars = var.regex_replace_chars
  delimiter           = "-"
  attributes          = ["dyn"]
  additional_tag_map  = {} /* Additional attributes (e.g. 1) */
}

