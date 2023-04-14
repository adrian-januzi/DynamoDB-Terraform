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