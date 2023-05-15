import os
import boto3
import json

# Get AWS credentials from environment variables
aws_access_key_id = os.environ['AWS_ACCESS_KEY_ID']
aws_secret_access_key = os.environ['AWS_SECRET_ACCESS_KEY']

# Create an instance of the Lambda client
client = boto3.client('lambda', aws_access_key_id=aws_access_key_id,
                      aws_secret_access_key=aws_secret_access_key)

# Define the test function
def test_lambda_function():
    payload = json.dumps({"key1": "value1", "key2": "value2", "key3": "value3"})
    response = client.invoke(FunctionName='VisitorCounterAPI',
                             Payload=payload)
    # Verify the response
    response_payload = json.load(response['Payload'])
    assert response['StatusCode'] == 200
    assert response_payload == {"status": "success"}

# Call the test function
test_lambda_function()
