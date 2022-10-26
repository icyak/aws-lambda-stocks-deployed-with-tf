resource "random_pet" "lambda_bucket_name" {
  prefix = "lambda-stocks"
  length = 4
}
resource "aws_s3_bucket" "lambda_bucket" {
  bucket        = random_pet.lambda_bucket_name.id
  force_destroy = true
}
resource "aws_s3_bucket" "lambda_bucket_output" {
  bucket        = var.output_bucket
  force_destroy = true
}
resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.lambda_bucket_output.id
  acl    = "public-read"
}
resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.lambda_bucket.id
  acl    = "private"
}

### SSM parameters
resource "aws_ssm_parameter" "output_bucket" {
  name  = "/lambda_stocks/output_bucket"
  type  = "String"
  value = var.output_bucket
}

### Eventbus cronjob
resource "aws_cloudwatch_event_rule" "lambda_event_rule" {
  name                = "lambda-event-rule-run-every-24-hours"
  description         = "retry scheduled every 24 hours"
  schedule_expression = "rate(24 hours)"
}
resource "aws_cloudwatch_event_target" "lambda_event_rule_target" {
  arn   = aws_lambda_function.lambda_stocks.arn
  rule  = aws_cloudwatch_event_rule.lambda_event_rule.name
}
resource "aws_lambda_permission" "allow_cloudwatch_to_call_rw_fallout_retry_step_deletion_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_stocks.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_event_rule.arn
}

##############
data "archive_file" "lambda_stocks" {
  type        = "zip"
  source_dir  = "${path.module}/python"
  output_path = "${path.module}/python/${var.lambda_name}.zip"
}

resource "aws_s3_object" "lambda_stocks" {
  bucket  = aws_s3_bucket.lambda_bucket.id
  key     = var.lambda_name
  source  = data.archive_file.lambda_stocks.output_path
  etag    = filemd5(data.archive_file.lambda_stocks.output_path)
}

########### create lambda
resource "aws_lambda_function" "lambda_stocks" {
  function_name     = var.lambda_function_name
  s3_bucket         = aws_s3_bucket.lambda_bucket.id
  s3_key            = aws_s3_object.lambda_stocks.key
  runtime           = "python3.7"
  handler           = var.lambda_function_handler
  source_code_hash  = data.archive_file.lambda_stocks.output_base64sha256
  role              = aws_iam_role.lambda_exec.arn
  environment {
    variables       = {
      STOCK_CAD     = var.lambda_function_variable_stock_cad
      STOCK_CHF     = var.lambda_function_variable_stock_chf
      STOCK_EUR     = var.lambda_function_variable_stock_eu
      STOCK_GBP     = var.lambda_function_variable_stock_eng
      STOCK_USD     = var.lambda_function_variable_stock_usa
      OUTPUT_BUCKET = aws_ssm_parameter.output_bucket.value
    }
  }
}

resource "aws_iam_role" "lambda_exec" {
  name = "serverless_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "sts:AssumeRole"
      ]
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  for_each = toset([
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
  ])
  role       = aws_iam_role.lambda_exec.name
  policy_arn = each.value

}
