data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/python"
  output_path = "${path.module}/python/hello-python.zip"
}

resource "aws_lambda_function" "aws_lambda_function" {
  filename      = "${path.module}/python/hello-python.zip"
  function_name = "terraform_lambda_function"
  role          = aws_iam_role.Lamda_role.arn
  handler       = "hello-python.lambda_handler"
  runtime       = "python3.9"
  depends_on    = [aws_iam_policy_attachment.attach_iam_policy_to_iam_role]
  publish = true #publish a new version of the Lambda function each time the code changes
  vpc_config {
    subnet_ids                  = var.subnet_ids
    security_group_ids          = var.security_group_ids
    ipv6_allowed_for_dual_stack = false # Enable IPv6 support
  }
  tags = local.common_tags

}


resource "aws_lambda_alias" "my_lambda_alias" {
    name             = "production"
  description      = "Production alias"
  function_name    = aws_lambda_function.aws_lambda_function.function_name
  function_version = aws_lambda_function.aws_lambda_function.version
  
}



 