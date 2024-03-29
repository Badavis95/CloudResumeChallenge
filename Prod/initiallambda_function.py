import json
import boto3
from boto3.dynamodb.conditions import Key # this is used for the DynamoDB Table Resource

TABLE_NAME = "VisitorCounter"  # Used to declare table 
# Creating the DynamoDB Client
dynamodb_client = boto3.client('dynamodb', region_name="us-east-1")

# Creating the DynamoDB Table Resource
dynamodb_table = boto3.resource('dynamodb', region_name="us-east-1")
table = dynamodb_table.Table(TABLE_NAME)

# Use the DynamoDB Table update item method to increment item
def lambda_handler(event, context):
    response = table.get_item(
        TableName =TABLE_NAME,
        Key={
            "WebsiteVisits":'Site',
        }
        )
    item = response['Item']

    table.update_item(
        Key={
            "WebsiteVisits":'Site',
        },
        UpdateExpression='SET VisitCount = :val1',
        ExpressionAttributeValues={
            ':val1': item['VisitCount'] + 1
        }
    )
    return{
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        },
      "body": json.dumps({"Visit_Count": str(item['VisitCount'] + 1)})
    }
