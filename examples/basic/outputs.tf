output "aws_access_key_id" {
  value = module.castai-aws-iam.aws_access_key_id
}

output "aws_secret_access_key" {
  value     = module.castai-aws-iam.aws_secret_access_key
  sensitive = true
}

output "user_arn" {
  value = module.castai-aws-iam.user_arn
}

output "user_name" {
  value = module.castai-aws-iam.user_name
}

output "instance_profile_role_arn" {
  value = module.castai-aws-iam.instance_profile_role_arn
}
