resource "aws_eks_cluster" "jlabs_eks_poc" {
  name = "jlabs_eks_poc"

  access_config {
    authentication_mode = "API"
  }

  role_arn = aws_iam_role.jlabs_eks_poc_cluster.arn
  version  = "1.31"

  bootstrap_self_managed_addons = false

  # compute_config block is required for EKS Auto Mode, with enabled = true
  compute_config {
    enabled       = true
    node_pools    = ["general-purpose"]
    node_role_arn = aws_iam_role.jlabs_eks_poc_node.arn
  }

  kubernetes_network_config {
    elastic_load_balancing {
      enabled = true
    }
  }

  storage_config {
    block_storage {
      enabled = true
    }
  }

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true

    subnet_ids = module.jlabs_eks_poc_vpc.private_subnets
  }

  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSComputePolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSBlockStoragePolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSLoadBalancingPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSNetworkingPolicy,
  ]
}

