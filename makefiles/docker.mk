.PHONY: bash
bash:
	docker-compose exec ${SERVICE_NAME} /bin/bash


.PHONY: scan_image
scan_image:
	docker scan --json ${IMAGE_NAME} --severity=high > docker-scan-result.json


.PHONY: tag
tag:
	docker tag ${IMAGE_ID} ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${TAG}


.PHONY: push_image
push_image: tag
	docker push ${DOCKER_HUB_USERNAME}/${IMAGE_NAME}:${TAG}


.PHONY: remove_container
remove_container:
	docker-compose rm


remove_all_images:
	docker-compose down --rmi all --volumes --remove-orphans
