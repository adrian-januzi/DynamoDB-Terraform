output "dynamodb_details" {
    value = {
        table_arn = join("", aws_dynamodb_table.dynamodb_table.*.arn)
        table_stream_arn = join("", aws_dynamodb_table.dynamodb_table.*.stream_arn)

    }
}


output "iam_user_keys" {
    value = {
        access_key : aws_iam_access_key.dynamodb_access_key.id,
        access_secret : nonsensitive(aws_iam_access_key.dynamodb_access_key.secret)
    }
}