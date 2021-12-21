terraform {
  required_providers {
    castai = {
      source  = "castai/castai"
      version = ">= 0.8.1"
    }
    aws    = {
      source  = "hashicorp/aws"
      version = ">= 2.49"
    }
  }
  required_version = ">= 0.13"
}
