terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "kubernetes-learnings-robin-nagpal"
    key = "terraform-state/kubernetes-tutorials/06_tools/03_kops"
    region = "us-east-1"
  }

}

provider "aws" {
  region = "us-east-1"
}

variable "environment" {
  default = "prod"
}

data "aws_caller_identity" "iam" {}

data "aws_iam_user" "kubernetes_cluster_user" {
  user_name = "kubernetes_cluster_user"
}

resource "aws_iam_role" "cert_manager" {
  name = "cert_manager"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid = ""
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.iam.account_id}:root"
        }
      },
    ]
  })
}

data "aws_iam_policy_document" "cert_manager_policy_doc" {
  statement {
    effect = "Allow"
    actions = ["route53:GetChange"]
    resources = ["arn:aws:route53:::change/*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:ListResourceRecordSets"
    ]
    resources = [
      "arn:aws:route53:::hostedzone/*"]
  }
  statement {
    effect = "Allow"
    actions = ["route53:ListHostedZonesByName"]
    resources = [ "*"]
  }

}

resource "aws_iam_policy" "cert_manager_policy" {
  name = "cert_manager_policy_document"
  policy = data.aws_iam_policy_document.cert_manager_policy_doc.json
}
resource "aws_iam_role_policy_attachment" "cert_manager_policy_attachment" {
  policy_arn = aws_iam_policy.cert_manager_policy.arn
  role = aws_iam_role.cert_manager.id
}


data "aws_iam_policy_document" "cert_manager_assume_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]
    resources = [
      aws_iam_role.cert_manager.arn
    ]
    sid = "AllowAssumingOfRole"
  }
}

resource "aws_iam_policy" "cert_manager_assume_role_policy" {
  name = "cert_manager_role_assume_policy_document"
  policy = data.aws_iam_policy_document.cert_manager_assume_role_policy.json
}

resource "aws_iam_user_policy_attachment" "kubernetes_cluster_user_cert_manager_assume" {
  policy_arn = aws_iam_policy.cert_manager_assume_role_policy.arn
  user = data.aws_iam_user.kubernetes_cluster_user.user_name
}




