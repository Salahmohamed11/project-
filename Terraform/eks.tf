resource "aws_iam_role" "EKS" {
  name = "eks-cluster-EKS"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "EKS-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.main.name
}

variable "cluster_name" {
  default     = "main"
  type        = string
  description = "AWS EKS CLuster Name"
  nullable    = false
}

resource "aws_eks_cluster" "projectt" {
  name     = var.cluster_name
  role_arn = aws_iam_role.EKS.arn
 

  vpc_config {
    subnet_ids = [
      aws_subnet.private-us-east-1a.id,
      aws_subnet.private-us-east-1b.id,
      aws_subnet.public-us-east-1a.id,
      aws_subnet.public-us-east-1b.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.EKS-AmazonEKSClusterPolicy]
}