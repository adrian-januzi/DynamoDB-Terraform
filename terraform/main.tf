terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.63.0"
    }
  }
}


provider "aws" {
  region  = var.dynamodb_region
  profile = var.aws_credentials_profile
}


resource "aws_dynamodb_table" "dynamodb_table" {
    name           = var.dynamodb_name
    billing_mode   = "PROVISIONED"
    read_capacity  = 20
    write_capacity = 20
    hash_key       = "id"

    stream_enabled   = true
    stream_view_type = "NEW_AND_OLD_IMAGES"

    attribute {
        name = "id"
        type = "N"
    }

    ttl {
        attribute_name = "TimeToExist"
        enabled        = false
    }

    global_secondary_index {
        name               = "TableIndex"
        hash_key           = "id"
        write_capacity     = 20
        read_capacity      = 20
        projection_type    = "INCLUDE"
        non_key_attributes = ["id"]
    }

    tags = {
        Name = "Terraform Provisioned"
    }
}


# IAM User Policy
resource "aws_iam_user" "dynamodb_user" {
  name = "dynamodb_user"
}


resource "aws_iam_access_key" "dynamodb_access_key" {
  user = aws_iam_user.dynamodb_user.name
}


resource "aws_iam_user_policy" "dynamodb_policy" {
  name = "dynamodb-policy"
  user = aws_iam_user.dynamodb_user.name

  policy = jsonencode(
  {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Effect": "Allow",
              "Action": [
                  "dynamodb:DescribeTable",
                  "dynamodb:DescribeStream",
                  "dynamodb:ListTagsOfResource",
                  "dynamodb:DescribeLimits",
                  "dynamodb:GetRecords",
                  "dynamodb:GetShardIterator",
                  "dynamodb:Scan"
              ],
              "Resource": [
                  "${aws_dynamodb_table.dynamodb_table.*.arn[0]}"
              ]
          },
          {
              "Effect": "Allow",
              "Action": [
                  "dynamodb:*"
              ],
              "Resource": [
                  "${aws_dynamodb_table.dynamodb_table.*.arn[0]}/*"
              ]
          },
          {
              "Effect": "Allow",
              "Action": [
                  "dynamodb:ListStreams",
                  "dynamodb:ListTables",
                  "dynamodb:ListGlobalTables",
                  "tag:GetResources"
              ],
              "Resource": [
                  "*"
              ]
          }
      ]
  })
}