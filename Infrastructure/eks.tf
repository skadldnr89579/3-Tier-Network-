# EKS Cluster
resource "aws_eks_cluster" "status_eks" {
  name     = "status-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = aws_subnet.private[*].id # located in Private subnet
  }
}

# EKS nodes group (server instance)
resource "aws_eks_node_group" "nodes" {
  cluster_name    = aws_eks_cluster.status_eks.name
  node_group_name = "status-nodes"
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = aws_subnet.private[*].id

  scaling_config {
    desired_size = 2 # minimum 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t3.micro"] # suitable for minimum requirement
}