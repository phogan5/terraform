terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}


provider "aws" {
  region  = "us-east-1"
  profile = var.profile
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ssm_role"
  role = aws_iam_role.ec2_role.name
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "vpc_logging_trust_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy" "AmazonSSMManagedInstanceCore" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

data "aws_iam_policy" "CloudWatchLogsFullAccess" {
  arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_role_policy_attachment" "ssm_policy_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = data.aws_iam_policy.AmazonSSMManagedInstanceCore.arn
}

resource "aws_iam_role_policy_attachment" "cloudwatch_policy_attach" {
  role       = aws_iam_role.flow_logs_role.name
  policy_arn = data.aws_iam_policy.CloudWatchLogsFullAccess.arn
}

resource "aws_iam_role" "ec2_role" {
  name               = "ec2_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role" "flow_logs_role" {
  name               = "flow_logs_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.vpc_logging_trust_policy.json
}