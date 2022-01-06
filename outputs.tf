output "aws_access_key_id" {
  description = "ID of created AWS access key to onboard into CAST.AI"
  value       = aws_iam_access_key.castai.id
}

output "aws_secret_access_key" {
  description = "Secret of created AWS access key to onboard into CAST.AI"
  value       = aws_iam_access_key.castai.secret
  sensitive   = true
}

output "user_arn" {
  description = "Arn of created AWS user"
  value       = aws_iam_user.castai.arn
}

output "user_name" {
  description = "Name of created AWS user"
  value       = aws_iam_user.castai.name
}

output "instance_profile_arn" {
  description = "Arn of created instance profile"
  value       = aws_iam_instance_profile.instance_profile.arn
}

output "instance_profile_role_arn" {
  description = "Arn of created instance profile"
  value       = aws_iam_role.instance_profile_role.arn
}

