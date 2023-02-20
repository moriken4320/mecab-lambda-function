lib-install:
	echo "-- docker-compose up ----------------"
	docker-compose up

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

gene-pack:
	echo "-- generate library to packing ----------------"
	rm -f deploy_package.zip
	cd function && \
	zip -r ../deploy_package.zip * .*
	@make upload-to-s3

upload-to-s3:
	echo "-- zip to s3 ----------------"
	aws s3 cp ./deploy_package.zip s3://test-mori-python

update:
	echo "-- update ----------------"
	@make gene-pack
	aws lambda update-function-code --function-name dev-test-mecab-function --s3-bucket test-mori-python --s3-key deploy_package.zip
