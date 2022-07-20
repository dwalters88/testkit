#! /usr/bin/python3

import boto3
import sys
import json

from boto3.dynamodb.conditions import Key

try:
    TABLE_NAME = "valid-tns"

    # Creating the DynamoDB Client
    dynamodb_client = boto3.client('dynamodb', region_name="us-east-2")
except Exception as e:
   print ("SET VARIABLE VALIDTN \"Error\"")
 #  print (e)

try:
    response = dynamodb_client.get_item(
        TableName=TABLE_NAME,
        Key={
         'tn': {'S': sys.argv[1]},
         'app': {'S': sys.argv[2]}
        },
        ProjectionExpression='authorized'
    )
    line = str(response['Item']['authorized']['BOOL'])
    print ("SET VARIABLE VALIDTN \"" + line + "\"")

except Exception as e:
   print ("SET VARIABLE VALIDTN \"Not Found\"")
 #  print (e)
