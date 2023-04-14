variable "aws_credentials_profile" {
    description = "The credentials profile used to authenticate with AWS."
    type = string
}


variable "dynamodb_region" {
    description = "The region in which the DynamoDB will be hosted in on AWS."
    type = string
}


variable "dynamodb_name" {
    description = "The name given to the DynamoDB table."
    type = string
}


