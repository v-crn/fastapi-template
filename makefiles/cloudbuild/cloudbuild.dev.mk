.PHONY deploy_dev:
deploy_dev: config config_dev
	gcloud builds submit --config cloudbuild.yaml \
	--substitutions \
	^---^_PROJECT=${_PROJECT}\
	---_SERVICE=${_SERVICE}\
	---_SERVICE_ACCOUNT=${_SERVICE_ACCOUNT}\
	---_IMAGE=${_IMAGE}\
	---_REGION=${_REGION}\
	---_TARGET=${_TARGET}\
	---_MEMORY=${_MEMORY}\
	---_CPU=${_CPU}\
	---_MAX_INSTANCES=${_MAX_INSTANCES}\
	---_MIN_INSTANCES=${_MIN_INSTANCES}\
	---_CONCURRENCY=${_CONCURRENCY}\
	---_TIMEOUT=${_TIMEOUT}\
	---_DEBUG=${_DEBUG}\
	---_DOCKERFILE_PATH=${_DOCKERFILE_PATH}\
	---_WORK_DIR=${_WORK_DIR}\
	---_PORT=${_PORT}\
	---_SERVICE_NAME=${_SERVICE_NAME}\
	---_API_VERSION=${_API_VERSION}


.PHONY: check_files_for_upload
check_files_for_upload:
	gcloud meta list-files-for-upload
