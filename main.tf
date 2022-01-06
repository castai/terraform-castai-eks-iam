locals {
  resource_name_postfix = var.aws_cluster_name

  iam_user_name              = "castai-eks-${local.resource_name_postfix}"
  iam_policy_name            = var.create_iam_resources_per_cluster ? "CastEKSPolicy-${local.resource_name_postfix}" : "CastEKSPolicy-tf"
  iam_user_policy_name       = "castai-user-policy-${local.resource_name_postfix}"
  instance_profile_role_name = "castai-eks-instance-${local.resource_name_postfix}"
}

# castai eks settings (provides required iam policies)

data "castai_eks_settings" "eks" {
  account_id = var.aws_account_id
  vpc        = var.aws_cluster_vpc_id
  region     = var.aws_cluster_region
  cluster    = var.aws_cluster_name
}

# iam - user

resource "aws_iam_user" "castai" {
  name = local.iam_user_name
}

# iam - policies

resource "aws_iam_policy" "castai_iam_policy" {
  name   = local.iam_policy_name
  policy = data.castai_eks_settings.eks.iam_policy_json
}

# iam - policy attachments

resource "aws_iam_user_policy_attachment" "castai_iam_policy_attachment" {
  user       = aws_iam_user.castai.name
  policy_arn = aws_iam_policy.castai_iam_policy.arn
}

resource "aws_iam_user_policy" "castai_user_iam_policy" {
  name   = local.iam_user_policy_name
  user   = aws_iam_user.castai.name
  policy = data.castai_eks_settings.eks.iam_user_policy_json
}

resource "aws_iam_user_policy_attachment" "castai_iam_lambda_policy_attachment" {
  for_each = toset(data.castai_eks_settings.eks.lambda_policies)

  user       = aws_iam_user.castai.name
  policy_arn = each.value
}

# iam - instance profile role

resource "aws_iam_role" "instance_profile_role" {
  name               = local.instance_profile_role_name
  assume_role_policy = jsonencode({
    Version : "2012-10-17"
    Statement : [
      {
        Sid       = ""
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action    = ["sts:AssumeRole"]
      }
    ]
  })
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = local.instance_profile_role_name
  role = aws_iam_role.instance_profile_role.name
}

resource "aws_iam_role_policy_attachment" "castai_instance_profile_policy" {
  for_each = toset(data.castai_eks_settings.eks.instance_profile_policies)

  role       = aws_iam_instance_profile.instance_profile.role
  policy_arn = each.value
}

# iam - access key

resource "aws_iam_access_key" "castai" {
  user = aws_iam_user.castai.name
}
