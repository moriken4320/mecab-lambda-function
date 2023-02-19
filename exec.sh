#!/bin/bash
echo "-- layer to zip ----------------"
cp ./layer/mecab-layer.zip ./mecab/mecab-layer.zip
echo "-- function to zip ----------------"
zip ./mecab/mecab-function.zip ./lambda_function.py
echo "-- zip to s3 ----------------"
aws s3 cp ./mecab s3://test-mori-python/mecab --recursive
echo "-- cf deploy ----------------"
aws cloudformation deploy --template-file template.yml --stack-name "mecab-function-stack" --capabilities CAPABILITY_NAMED_IAM --parameter-overrides "file://template-configuration.json"
