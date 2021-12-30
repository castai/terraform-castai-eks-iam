variable "aws_account_id" {
  type        = string
  description = "ID of AWS account the cluster is located in."
}

variable "aws_cluster_region" {
  type        = string
  description = "Region of the cluster IAM resources will created for."
}

variable "aws_cluster_name" {
  type = string
  default = ""
}

variable "aws_access_key_id" {
  type = string
  default = ""
}

variable "aws_secret_access_key" {
  type = string
  default = ""
}

variable "aws_instance_profile_role_arn" {
  type = string
  default = ""
}