# 여기서는 EC2관련 IAM Role을 생성해주고
resource "aws_iam_role" "terraform-eks-node" {
  name = "terraform-eks-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# 위에서 생성한 IAM Role에 Policy를 추가한다
resource "aws_iam_role_policy_attachment" "terraform-eks-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.terraform-eks-node.name
}

# 위에서 생성한 IAM Role에 Policy를 추가한다
resource "aws_iam_role_policy_attachment" "terraform-eks-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.terraform-eks-node.name
}

# 위에서 생성한 IAM Role에 Policy를 추가한다
resource "aws_iam_role_policy_attachment" "terraform-eks-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.terraform-eks-node.name
}

# 마지막으로 Node Group을 생성한다.
resource "aws_eks_node_group" "terraform-eks-node1" {
  cluster_name    = aws_eks_cluster.terraform-eks-cluster.name
  node_group_name = "terraform-eks-node1"
  node_role_arn   = aws_iam_role.terraform-eks-node.arn
  subnet_ids      = aws_subnet.terraform-eks-private-subnet[*].id
  instance_types = ["t2.small"]
  disk_size = 50

  labels = {
    "role" = "terraform-eks-node1"
  }

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 3
  }

  depends_on = [
    aws_iam_role_policy_attachment.terraform-eks-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.terraform-eks-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.terraform-eks-node-AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
    "Name" = "${aws_eks_cluster.terraform-eks-cluster.name}-terraform-eks-node1-Node"
  }
}
/*
resource "aws_eks_node_group" "terraform-eks-node2" {
  cluster_name    = aws_eks_cluster.terraform-eks-cluster.name
  node_group_name = "terraform-eks-node2"
  node_role_arn   = aws_iam_role.terraform-eks-node.arn
  subnet_ids      = aws_subnet.terraform-eks-private-subnet[*].id
  instance_types = ["t2.small"]
  disk_size = 50

  labels = {
    "role" = "terraform-eks-node2"
  }

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 3
  }

  depends_on = [
    aws_iam_role_policy_attachment.terraform-eks-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.terraform-eks-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.terraform-eks-node-AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
    "Name" = "${aws_eks_cluster.terraform-eks-cluster.name}-terraform-eks-node2-Node"
  }
}
*/