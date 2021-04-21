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

resource "aws_s3_bucket" "jomo-click-kops-store" {
  bucket = "kops-jomo-click-state-store"

  tags = {
    Environment = var.environment
    Terraform = "true"
  }
}

resource "aws_iam_group" "kubernetes_viewers" {
  name = "kubernetes_viewer"
}


data "aws_iam_policy_document" "kubernetes_policy_document" {
  statement {
    actions = [
      "sts:AssumeRole"]
    effect = "Allow"
    resources = []
    sid = "kubernetes_viewers_assume"
  }
}

data "aws_iam_user" "kops-trainee-1" {
  user_name = "kops-trainee-1"
}

data "aws_iam_user" "kops-trainee-2" {
  user_name = "kops-trainee-2"
}

resource "aws_iam_role" "kubernetes_viewer" {
  name = "kubernetes_viewer"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid = ""
        Principal = {
          AWS = data.aws_iam_user.kops-trainee-1.arn
        }
      },
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid = ""
        Principal = {
          AWS = data.aws_iam_user.kops-trainee-2.arn
        }
      },
    ]
  })
}

//resource "aws_iam_role_policy_attachment" "ec2-read-only-policy-attachment" {
//  role = aws_iam_role.kubernetes_viewer.name
//  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
//}

