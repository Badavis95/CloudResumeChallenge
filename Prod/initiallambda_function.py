import json
import boto3


dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('VisitorCounter')

def lambda_handler(event, context):
    response = table.get_item(Key={
        'WebsiteVisits': 'Site'
    })
    VisitCount = response['Item']['VisitCount']
    VisitCount = int(VisitCount) + 1
    print(VisitCount)

    response = table.put_item(Item={
        'WebsiteVisits': 'Site',
        'VisitCount': VisitCount
    })

    return {
    'statusCode': 200,
    'headers': {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Credentials': 'true',
        'Content-Type': 'application/json'
    },
    'body': json.dumps({
        'visitorCount': VisitCount
    })
}
