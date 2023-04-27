
import boto3

# Create a reference to the DynamoDB table
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('VisitorCounter')

# Define the Lambda handler
def lambda_handler(event, context):
    # Get the request body
    body = event['body']
    
    # Parse the body to get the data
    data = json.loads(body)
    
    # Get the item from the data
    Visits = data['Count']
    
    # Update the table with the item
    table.update_item(
        Key={
            'item_name': Visits
             },
        UpdateExpression='SET item_status = :val1',
        ExpressionAttributeValues={
            ':val1': 'updated'
        }
    )
    
    # Return a response to the request
    return {
        'statusCode': 200,
        'body': json.dumps('Item has been updated')
    }