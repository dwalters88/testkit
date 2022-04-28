#!/usr/bin/bash

aws dynamodb create-table \
    --table-name valid-tns \
    --region us-east-2 \
    --attribute-definitions AttributeName=tn,AttributeType=S AttributeName=app,AttributeType=S \
    --key-schema AttributeName=tn,KeyType=HASH AttributeName=app,KeyType=RANGE \
    --billing-mode PAY_PER_REQUEST
