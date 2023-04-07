import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('VisitorCounter')

def lambda_handler(event, context):
    response = table.get_item(Key={ 
        'WebsiteVisits':'0'
    })
    VisitCount = response['Item']['VisitCount']
    VisitCount = VisitCount + 1
    print (VisitCount)
    response = table.put_item(Item={
	    	'WebsiteVisits':'0',
		    'VisitCount': VisitCount
					})
    return "Table updated successfully!" 
