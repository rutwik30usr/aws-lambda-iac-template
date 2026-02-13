resource "aws_iam_role" "Lamda_role" {
  name = "terraform_lambda_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
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

  tags = local.common_tags
}

resource "aws_iam_policy" "Lambda_policy" {
  name        = "terraform_lambda_policy"
  path        = "/"
  description = "A test policy for Lambda function"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface"
        ]
        Effect   = "Allow"
        Resource = "*"
      }


    ]
  })

  tags = local.common_tags
}

resource "aws_iam_policy_attachment" "attach_iam_policy_to_iam_role" {
  name       = "attach_iam_policy_to_iam_role"
  policy_arn = aws_iam_policy.Lambda_policy.arn
  roles      = [aws_iam_role.Lamda_role.name]

}