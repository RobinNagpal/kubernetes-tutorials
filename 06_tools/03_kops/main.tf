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

data "aws_caller_identity" "iam" {}

variable "environment" {
  default = "prod"
}


variable "readonly_users" {
  description = "readonly_users"
  default = [
    "readonly_user1",
    "readonly_user2",
    "readonly_user3"
  ]
}

variable "developers" {
  description = "developers"
  default = [
    "developers1",
    "developers2",
    "developers3"
  ]
}

resource "aws_iam_user" readonly_users {
  for_each = toset(var.readonly_users)
  name = "tf-test-${each.key}"
}

resource "aws_iam_user" developers {
  for_each = toset(var.developers)
  name = "tf-test-${each.key}"
}

resource "aws_iam_group" "tf-test-readonly_users" {
  name = "tf-test-readonly-users"
}
resource "aws_iam_group" "tf-test-developers" {
  name = "tf-test-developers"
}

resource "aws_iam_group_membership" "tf-test-readonly_users-membership" {
  group = aws_iam_group.tf-test-readonly_users.name
  name = "tf-test-readonly-users-membership"
  users = toset([for k in aws_iam_user.readonly_users : k.name])
}

resource "aws_iam_group_membership" "tf-test-developers-membership" {
  group = aws_iam_group.tf-test-developers.name
  name = "tf-test-developers-membership"
  users = toset([for k in aws_iam_user.developers : k.name])
}

resource "aws_iam_role" "kubernetes_readonly_user_role" {
  name = "kubernetes_readonly_users_role"
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

resource "aws_iam_role" "kubernetes_developer" {
  name = "kubernetes_developer_role"
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


data "aws_iam_policy_document" "group_assume_readonly_user_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]
    resources = [
      aws_iam_role.kubernetes_readonly_user_role.arn
    ]
    sid = "AllowAssumingOfRole"
  }
}


data "aws_iam_policy_document" "group_assume_developer_role_policy" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]
    resources = [
      aws_iam_role.kubernetes_developer.arn
    ]
    sid = "AllowAssumingOfRole"
  }
}

resource "aws_iam_group_policy" "readonly_user_group_policy" {
  group = aws_iam_group.tf-test-readonly_users.id
  name = "kubernetes_readonly_user_role_access"
  policy = data.aws_iam_policy_document.group_assume_readonly_user_role_policy.json
}


resource "aws_iam_group_policy" "developer_group_policy" {
  group = aws_iam_group.tf-test-developers.id
  name = "kubernetes_developer_role_access"
  policy = data.aws_iam_policy_document.group_assume_developer_role_policy.json
}
