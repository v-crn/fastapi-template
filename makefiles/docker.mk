.PHONY: bash
bash:
	docker-compose exec ${SERVICE_NAME} /bin/bash


.PHONY: clear
clear:
	docker-compose down --rmi all --volumes


.PHONY: scan_image
scan_image:
	docker scan --json ${IMAGE_NAME} --severity=high > docker-scan-result.json
