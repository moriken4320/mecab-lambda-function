init:
	echo "-- docker-compose up ----------------"
	docker-compose up
	@make gene-pack

gene-pack:
	echo "-- generate library to packing ----------------"
	rm deploy_package.zip
	cd function && \
	zip -r ../deploy_package.zip * .*
	@make upload-to-s3

upload-to-s3:
	echo "-- zip to s3 ----------------"
	aws s3 cp ./deploy_package.zip s3://test-mori-python

cf-deploy:
	echo "-- cf deploy ----------------"
	aws cloudformation deploy --template-file template.yml --stack-name "mecab-function-stack" --capabilities CAPABILITY_NAMED_IAM --parameter-overrides "file://template-configuration.json"

cf-delete:
	echo "-- cf delete ----------------"
	aws cloudformation delete-stack --stack-name "mecab-function-stack"

update:
	echo "-- update ----------------"
	@make gene-pack
	aws lambda update-function-code --function-name dev-test-mecab-function --s3-bucket test-mori-python --s3-key deploy_package.zip

exec:
	echo "-- function exec ----------------"
	aws lambda invoke --function-name dev-test-mecab-function --payload file://input.json output.json
