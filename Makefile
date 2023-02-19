init:
	echo "-- docker-compose up ----------------"
	docker-compose up
	@make gene-pack

gene-pack:
	rm deploy_package.zip
	@make gene-lib-pack
	@make func-into-pack
	@make upload-to-s3

gene-lib-pack:
	echo "-- generate library to packing ----------------"
	cd library && \
	zip -r ../deploy_package.zip * .*

func-into-pack:
	echo "-- function into packing ----------------"
	zip -g deploy_package.zip lambda_function.py

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
	aws lambda update-function-code --function-name dev-test-mecab-function --s3-bucket test-mori-python --s3-key deploy_package.zip
