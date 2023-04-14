Provisions a basic DynamoDB on AWS. By default:
- the partition key set to `{ "id" : N }`.
- streaming enabled and view type set to `NEW_AND_OLD_IMAGES`.
- read and write capacity set to 20.


To Run:
1. Set the following environment variables either through using `export <var>` in a shell script/console or a `.env` file:
    - AWS_CREDENTIALS_PROIFLE=
    - DYNAMODBDB_NAME=
    - DYNAMODB_REGION=

2. In the console, run: `make start`.

3. Confirm the DynamoDB table has been created on AWS.
