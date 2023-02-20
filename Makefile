re-build:
	docker-compose build --no-cache

down:
	docker-compose down

update-layer:
	echo "-- docker-compose up ----------------"
	docker-compose up
	@make upload-to-s3

cf-deploy:
	echo "-- cf deploy ----------------"
	aws cloudformation package --template-file template.yml --s3-bucket test-mori-python --output-template-file outputtemplate.yml
	aws cloudformation deploy --template-file outputtemplate.yml --stack-name mecab-function-stack --capabilities CAPABILITY_NAMED_IAM --parameter-overrides file://template-configuration.json

cf-delete:
	echo "-- cf delete ----------------"
	aws cloudformation delete-stack --stack-name mecab-function-stack

exec:
	echo "-- function exec ----------------"
	aws lambda invoke --function-name dev-test-mecab-function --payload file://input.json output.json

upload-to-s3:
	echo "-- zip to s3 ----------------"
	aws s3 cp ./layers/deploy_package.zip s3://test-mori-python
