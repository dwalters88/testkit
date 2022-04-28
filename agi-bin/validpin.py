#! /usr/bin/python3

import boto3
import sys
import json

from boto3.dynamodb.conditions import Key

try:
    TABLE_NAME = "valid-pins"

    # Creating the DynamoDB Client
    dynamodb_client = boto3.client('dynamodb', region_name="us-east-2")
except:
    print ("SET VARIABLE VALIDPIN \"Error\"")

try:
    response = dynamodb_client.get_item(
        TableName=TABLE_NAME,
        Key={
            'pin': {'S': sys.argv[1]},
            },
        ProjectionExpression='username'
    )
    line = str(response['Item']['username']['S'])
    #print ("SET VARIABLE VALIDPIN \"" + line + "\"")
    print ("SET VARIABLE VALIDPIN \"True\"")

except:
    print ("SET VARIABLE VALIDPIN \"Not Found\"")
