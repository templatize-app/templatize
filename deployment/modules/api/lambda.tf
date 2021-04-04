locals {
  lambda_fn_name = "templatize_api_${var.environment}"
  zip_file_path  = "${path.module}/files/templatize.zip"
}

data "archive_file" "lambda_archive" {
  type        = "zip"
  source_file = "${path.root}/../api-router-lambda/index.js"
  output_path = local.zip_file_path
}

resource "aws_iam_role" "lambda_role" {
  name = "lamdba-${local.lambda_fn_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  tags = local.tags
}

resource "aws_iam_policy" "lambda_dynamo_connectivity"{
  name   = "allowLambdaDynamoDBAccess"
  policy = templatefile("${path.module}/iam_policies/lambda_role_policy.json.tpl", { dynamo_arn = aws_dynamodb_table.template_table.arn })
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_dynamo_connectivity.arn
}

resource "aws_lambda_permission" "permissions"{
  statement_id  = "AllowLambdaInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.template_lambda_router.function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway HTTP API.
  source_arn = "${aws_apigatewayv2_api.tmpltz_api.execution_arn}/*/*"
}

resource "aws_lambda_function" "template_lambda_router" {
  filename      = local.zip_file_path
  function_name = local.lambda_fn_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"

  source_code_hash = data.archive_file.lambda_archive.output_base64sha256

  runtime = "nodejs14.x"

  environment {
    variables = {
      TMPLTZ_TABLENAME = aws_dynamodb_table.template_table.name
    }
  }

  tags = local.tags
}