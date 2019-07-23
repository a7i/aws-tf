build:
	docker build . --no-cache -t amiralavi/aws-tf:latest
	docker tag amiralavi/aws-tf:latest amiralavi/aws-tf:0.12.5

push:
	docker push amiralavi/aws-tf:latest
	docker push amiralavi/aws-tf:0.12.5