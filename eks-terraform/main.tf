# ----------------------------
# EKS Cluster
# ----------------------------
resource "aws_eks_cluster" "eks" {
  name     = "project-eks"
  role_arn = aws_iam_role.master.arn

  vpc_config {
    subnet_ids         = [data.aws_subnet.subnet-1.id, data.aws_subnet.subnet-2.id]
    security_group_ids = [data.aws_security_group.selected.id]
  }

  tags = {
    Name        = "ankur-eks-cluster"
    Environment = "dev"
    Terraform   = "true"
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]
}
# ----------------------------
# EKS Node Group
# ----------------------------
resource "aws_eks_node_group" "node-grp" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.worker.arn
  subnet_ids      = [data.aws_subnet.subnet-1.id, data.aws_subnet.subnet-2.id]
  capacity_type   = "ON_DEMAND"
  disk_size       = 20
  instance_types  = ["t2.large"]

  labels = {
    env = "dev"
  }

  tags = {
    Name = "project-eks-node-group"
  }

  scaling_config {
    desired_size = 2
    max_size     = 10
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonSSMManagedInstanceCore,
    aws_iam_role_policy_attachment.autoscaler,
  ]
}

# ----------------------------
# OIDC Provider for ServiceAccount IAM Roles
# ----------------------------
data "aws_eks_cluster" "eks_oidc" {
  name = aws_eks_cluster.eks.name
}

data "tls_certificate" "oidc_thumbprint" {
  url = data.aws_eks_cluster.eks_oidc.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks_oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.oidc_thumbprint.certificates[0].sha1_fingerprint]
  url             = data.aws_eks_cluster.eks_oidc.identity[0].oidc[0].issuer
}