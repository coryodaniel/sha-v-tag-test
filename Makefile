IMAGE_URL=quay.io/coryodaniel/sha-v-tag

.PHONY: v1 v2 v1.push v2.push v1.deploy v2.deploy run

v1:
	docker build . -f Dockerfile.1.1 -t ${IMAGE_URL}:latest -t ${IMAGE_URL}:0.1 -t ${IMAGE_URL}:0.1.1

v2:
	docker build . -f Dockerfile.1.2 -t ${IMAGE_URL}:latest -t ${IMAGE_URL}:0.1 -t ${IMAGE_URL}:0.1.2

v1.push: v1
	docker push ${IMAGE_URL}:latest
	docker push ${IMAGE_URL}:0.1
	docker push ${IMAGE_URL}:0.1.1

v2.push: v2
	docker push ${IMAGE_URL}:latest
	docker push ${IMAGE_URL}:0.1
	docker push ${IMAGE_URL}:0.1.2

v1.deploy:
	kubectl apply -f deploy.v1.yaml

v2.deploy:
	kubectl apply -f deploy.v2.yaml

run: v1.push v1.deploy v2.push v2.deploy

log:
	kubectl log deployment/sha-v-tag -f
