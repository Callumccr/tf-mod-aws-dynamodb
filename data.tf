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