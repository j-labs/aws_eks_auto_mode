resource "aws_iam_role" "jlabs_eks_poc_node" {
  name = "eks_auto_mode-jlabs_eks_poc-node-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = ["sts:AssumeRole"]
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKSWorkerNodeMinimalPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodeMinimalPolicy"
  role       = aws_iam_role.jlabs_eks_poc_node.name
}

resource "aws_iam_role_policy_attachment" "node_AmazonEC2ContainerRegistryPullOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"
  role       = aws_iam_role.jlabs_eks_poc_node.name
}

resource "aws_iam_role" "jlabs_eks_poc_cluster" {
  name = "eks_auto_mode-jlabs_eks_poc-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.jlabs_eks_poc_cluster.name
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSComputePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSComputePolicy"
  role       = aws_iam_role.jlabs_eks_poc_cluster.name
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSBlockStoragePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSBlockStoragePolicy"
  role       = aws_iam_role.jlabs_eks_poc_cluster.name
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSLoadBalancingPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSLoadBalancingPolicy"
  role       = aws_iam_role.jlabs_eks_poc_cluster.name
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSNetworkingPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSNetworkingPolicy"
  role       = aws_iam_role.jlabs_eks_poc_cluster.name
}

# I added my user to the EKS cluster, as it was not included in the example from Terraform docs.

resource "aws_eks_access_entry" "jan_tyminski" {
  cluster_name  = aws_eks_cluster.jlabs_eks_poc.name
  principal_arn = data.aws_iam_user.jan_tyminski.arn
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "jan_tyminski_AmazonEKSAdminPolicy" {
  cluster_name  = aws_eks_cluster.jlabs_eks_poc.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
  principal_arn = aws_eks_access_entry.jan_tyminski.principal_arn

  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_access_policy_association" "jan_tyminski_AmazonEKSClusterAdminPolicy" {
  cluster_name  = aws_eks_cluster.jlabs_eks_poc.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = aws_eks_access_entry.jan_tyminski.principal_arn

  access_scope {
    type = "cluster"
  }
}