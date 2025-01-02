# Outputs in this PoC are not necessary, but I will add them for the sake of completeness
# and have commands to update kubeconfig and describe the cluster ready for me.

output "eks_cluster_name" {
  value = aws_eks_cluster.jlabs_eks_poc.name
}

output "eks_cluster_region" {
  value = data.aws_region.current.name
}

output "update_kubeconfig" {
  value = "aws eks --region ${data.aws_region.current.name} update-kubeconfig --name ${aws_eks_cluster.jlabs_eks_poc.name}"
}

output "describe_cluster" {
  value = "aws eks --region ${data.aws_region.current.name} describe-cluster --name ${aws_eks_cluster.jlabs_eks_poc.name}"
}
