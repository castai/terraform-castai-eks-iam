resource "castai_eks_cluster" "my_castai_cluster" {
  account_id = var.aws_account_id
  region     = var.aws_cluster_region
  name       = var.aws_cluster_name

  access_key_id        = var.aws_access_key_id
  secret_access_key    = var.aws_secret_access_key
  instance_profile_arn = var.aws_instance_profile_role_arn
}

resource "helm_release" "castai_agent" {
  name            = "castai-agent"
  repository      = "https://castai.github.io/helm-charts"
  chart           = "castai-agent"
  cleanup_on_fail = true

  set {
    name  = "provider"
    value = "eks"
  }

  set_sensitive {
    name  = "apiKey"
    value = castai_eks_cluster.my_castai_cluster.cluster_token
  }
}

resource "helm_release" "castai_cluster_controller" {
  name            = "castai-cluster-controller"
  repository      = "https://castai.github.io/helm-charts"
  chart           = "castai-cluster-controller"
  cleanup_on_fail = true

  set {
    name = "castai.clusterID"
    value = castai_eks_cluster.my_castai_cluster.id
  }

  set_sensitive {
    name  = "castai.apiKey"
    value = castai_eks_cluster.my_castai_cluster.cluster_token
  }
}
