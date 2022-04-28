#!/usr/bin/bash

aws dynamodb batch-write-item \
    --region us-east-2 \
    --request-items file://validtns-example-data.json 
