output "aws_iam_role_output" {
  value = aws_iam_role.Lamda_role.name
}

output "aws_iam_role_output_arn" {
  value = aws_iam_role.Lamda_role.arn

}


output "aws_iam_policy_output" {
  value = aws_iam_policy.Lambda_policy.arn
}

output "lambda_alias_arn" {
  value = aws_lambda_alias.my_lambda_alias.arn
}