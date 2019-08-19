
resource "aws_dynamodb_table" "default" {
  count            = length(var.dynamo_tables)
  name             = format("%s%s%s", module.dynamo_label.id, var.delimiter, element(var.dynamo_tables, count.index))
  billing_mode     = var.billing_mode
  read_capacity    = var.autoscale_min_read_capacity
  write_capacity   = var.autoscale_min_write_capacity
  hash_key         = var.hash_key
  stream_enabled   = var.enable_streams
  stream_view_type = var.enable_streams ? var.stream_view_type : ""
  attribute {
    name = format("%s", var.hash_key)
    type = format("%s", var.hash_key_type)
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    sid = ""

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["application-autoscaling.amazonaws.com"]
    }

    effect = "Allow"
  }
}

resource "aws_iam_role" "autoscaler" {
  count              = var.enable_autoscaler ? 1 : 0
  name               = "${module.dynamo_label.id}${var.delimiter}autoscaler"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = module.dynamo_label.tags
}

data "aws_iam_policy_document" "autoscaler" {
  count = var.enable_autoscaler ? length(var.dynamo_tables) : 0
  statement {
    sid = ""

    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:UpdateTable"
    ]

    resources = [element(aws_dynamodb_table.default.*.arn, count.index)]


    effect = "Allow"
  }
}

resource "aws_iam_role_policy" "autoscaler" {
  count  = var.enable_autoscaler ? length(var.dynamo_tables) : 0
  name   = format("%s%s%s%s%s", module.dynamo_label.id, var.delimiter, element(var.dynamo_tables, count.index), var.delimiter, "autoscaler")
  role   = join("", aws_iam_role.autoscaler.*.id)
  policy = element(data.aws_iam_policy_document.autoscaler.*.json, count.index)
}

data "aws_iam_policy_document" "autoscaler_cloudwatch" {
  statement {
    sid = ""

    actions = [
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:DeleteAlarms"
    ]

    resources = ["*"]

    effect = "Allow"
  }
}

resource "aws_iam_role_policy" "autoscaler_cloudwatch" {
  count  = var.enable_autoscaler ? 1 : 0
  name   = "${module.dynamo_label.id}${var.delimiter}autoscaler${var.delimiter}cloudwatch"
  role   = join("", aws_iam_role.autoscaler.*.id)
  policy = data.aws_iam_policy_document.autoscaler_cloudwatch.json
}

resource "aws_appautoscaling_target" "read_target" {
  count              = var.enable_autoscaler ? length(var.dynamo_tables) : 0
  max_capacity       = var.autoscale_max_read_capacity
  min_capacity       = var.autoscale_min_read_capacity
  resource_id        = "table/${element(aws_dynamodb_table.default.*.name, count.index)}"
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

# resource "aws_appautoscaling_target" "read_target_index" {
#   count              = var.enable_autoscaler ? length(var.dynamo_tables) : 0
#   max_capacity       = var.autoscale_max_read_capacity
#   min_capacity       = var.autoscale_min_read_capacity
#   resource_id        = "table/${element(aws_dynamodb_table.default.*.name, count.index)}/index/" #${element(var.dynamodb_indexes, count.index)}"
#   scalable_dimension = "dynamodb:index:ReadCapacityUnits"
#   service_namespace  = "dynamodb"
# }

resource "aws_appautoscaling_policy" "read_policy" {
  count       = var.enable_autoscaler ? length(var.dynamo_tables) : 0
  name        = "DynamoDBReadCapacityUtilization:${format("%s", element(aws_appautoscaling_target.read_target.*.resource_id, count.index))}"
  policy_type = "TargetTrackingScaling"
  resource_id = format("%s", element(aws_appautoscaling_target.read_target.*.resource_id, count.index))

  scalable_dimension = format("%s", element(aws_appautoscaling_target.read_target.*.scalable_dimension, count.index))
  service_namespace  = format("%s", element(aws_appautoscaling_target.read_target.*.service_namespace, count.index))
  # service_namespace  = format("%s%s%s",join("", element(aws_appautoscaling_target.read_target.*.service_namespace, count.index))))

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }

    target_value = var.autoscale_read_target
  }
}

# resource "aws_appautoscaling_policy" "read_policy_index" {
#   count = var.enable_autoscaler ? length(var.dynamo_tables) : 0

#   name = "DynamoDBReadCapacityUtilization:${element(
#     aws_appautoscaling_target.read_target_index.*.resource_id,
#     count.index
#   )}"

#   policy_type        = "TargetTrackingScaling"
#   resource_id        = aws_appautoscaling_target.read_target_index.*.resource_id[count.index]
#   scalable_dimension = aws_appautoscaling_target.read_target_index.*.scalable_dimension[count.index]
#   service_namespace  = aws_appautoscaling_target.read_target_index.*.service_namespace[count.index]

#   target_tracking_scaling_policy_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "DynamoDBReadCapacityUtilization"
#     }

#     target_value = var.autoscale_read_target
#   }
# }

resource "aws_appautoscaling_target" "write_target" {
  count              = var.enable_autoscaler ? length(var.dynamo_tables) : 0
  max_capacity       = var.autoscale_max_write_capacity
  min_capacity       = var.autoscale_min_write_capacity
  resource_id        = "table/${element(aws_dynamodb_table.default.*.name, count.index)}"
  scalable_dimension = "dynamodb:table:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

# resource "aws_appautoscaling_target" "write_target_index" {
#   count              = var.enable_autoscaler ? length(var.dynamo_tables) : 0
#   max_capacity       = var.autoscale_max_write_capacity
#   min_capacity       = var.autoscale_min_write_capacity
#   resource_id        = "table/${element(aws_dynamodb_table.default.name, count.index)}/index/" #${element(var.dynamodb_indexes, count.index)}"
#   scalable_dimension = "dynamodb:index:WriteCapacityUnits"
#   service_namespace  = "dynamodb"
# }

resource "aws_appautoscaling_policy" "write_policy" {
  count       = var.enable_autoscaler ? length(var.dynamo_tables) : 0
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

# resource "aws_appautoscaling_policy" "write_policy_index" {
#   count = var.enable_autoscaler ? length(var.dynamo_tables) : 0

#   name = "DynamoDBWriteCapacityUtilization:${element(
#     aws_appautoscaling_target.write_target_index.*.resource_id,
#     count.index
#   )}"

#   policy_type        = "TargetTrackingScaling"
#   resource_id        = aws_appautoscaling_target.write_target_index.*.resource_id[count.index]
#   scalable_dimension = aws_appautoscaling_target.write_target_index.*.scalable_dimension[count.index]
#   service_namespace  = aws_appautoscaling_target.write_target_index.*.service_namespace[count.index]

#   target_tracking_scaling_policy_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "DynamoDBWriteCapacityUtilization"
#     }

#     target_value = var.autoscale_write_target
#   }
# }

