provider "castai" {
  api_token = var.castai_api_token
}

provider "aws" {
  region     = var.aws_cluster_region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

module "castai-aws-iam" {
  source = "../../"

  aws_account_id     = var.aws_account_id
  aws_cluster_vpc_id = var.aws_vpc_id
  aws_cluster_region = var.aws_cluster_region
  aws_cluster_name   = var.aws_cluster_name

  create_iam_resources_per_cluster = true
}
