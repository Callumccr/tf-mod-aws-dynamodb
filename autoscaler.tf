resource "aws_iam_role" "autoscaler" {
  count              = var.enabled == true && var.enable_autoscaler != false ? 1 : 0
  name               = "${module.label.id}${var.delimiter}autoscaler"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = module.label.tags
}

resource "aws_iam_role_policy" "autoscaler" {
  count  = var.enabled == true && var.enable_autoscaler != false ? length(var.dynamo_table_names) : 0
  name   = format("%s%s%s%s%s", module.label.id, var.delimiter, element(var.dynamo_table_names, count.index), var.delimiter, "autoscaler")
  role   = join("", aws_iam_role.autoscaler.*.id)
  policy = element(data.aws_iam_policy_document.autoscaler.*.json, count.index)
}

resource "aws_iam_role_policy" "autoscaler_cloudwatch" {
  count  = var.enabled == true && var.enable_autoscaler != false ? 1 : 0
  name   = "${module.label.id}${var.delimiter}autoscaler${var.delimiter}cloudwatch"
  role   = join("", aws_iam_role.autoscaler.*.id)
  policy = data.aws_iam_policy_document.autoscaler_cloudwatch.json
}

resource "aws_appautoscaling_target" "read_target" {
  count              = var.enabled == true && var.enable_autoscaler != false ? length(var.dynamo_table_names) : 0
  max_capacity       = var.autoscale_max_read_capacity
  min_capacity       = var.autoscale_min_read_capacity
  resource_id        = "table/${element(aws_dynamodb_table.default.*.name, count.index)}"
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "read_policy" {
  count       = var.enabled == true && var.enable_autoscaler != false ? length(var.dynamo_table_names) : 0
  name        = "DynamoDBReadCapacityUtilization:${format("%s", element(aws_appautoscaling_target.read_target.*.resource_id, count.index))}"
  policy_type = "TargetTrackingScaling"
  resource_id = format("%s", element(aws_appautoscaling_target.read_target.*.resource_id, count.index))

  scalable_dimension = format("%s", element(aws_appautoscaling_target.read_target.*.scalable_dimension, count.index))
  service_namespace  = format("%s", element(aws_appautoscaling_target.read_target.*.service_namespace, count.index))

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }

    target_value = var.autoscale_read_target
  }
}

resource "aws_appautoscaling_target" "write_target" {
  count              = var.enabled == true && var.enable_autoscaler != false ? length(var.dynamo_table_names) : 0
  max_capacity       = var.autoscale_max_write_capacity
  min_capacity       = var.autoscale_min_write_capacity
  resource_id        = "table/${element(aws_dynamodb_table.default.*.name, count.index)}"
  scalable_dimension = "dynamodb:table:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "write_policy" {
  count       = var.enabled == true && var.enable_autoscaler != false ? length(var.dynamo_table_names) : 0
  name        = "DynamoDBWriteCapacityUtilization:${format("%s", element(aws_appautoscaling_target.write_target.*.resource_id, count.index))}"
  policy_type = "TargetTrackingScaling"
  resource_id = format("%s", element(aws_appautoscaling_target.write_target.*.resource_id, count.index))

  scalable_dimension = format("%s", element(aws_appautoscaling_target.write_target.*.scalable_dimension, count.index))
  service_namespace  = format("%s", element(aws_appautoscaling_target.write_target.*.service_namespace, count.index))

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }

    target_value = var.autoscale_write_target
  }
}
