.PHONY deploy_dev:
deploy_dev: config config_dev
	gcloud builds submit --config cloudbuild.yaml \
	--substitutions \
	^---^_API_VERSION=${_API_VERSION}\
	---_CONCURRENCY=${_CONCURRENCY}\
	---_CPU=${_CPU}\
	---_DEBUG=${_DEBUG}\
	---_DOCKERFILE_PATH=${_DOCKERFILE_PATH}\
	---_IMAGE=${_IMAGE}\
	---_MAX_INSTANCES=${_MAX_INSTANCES}\
	---_MEMORY=${_MEMORY}\
	---_MIN_INSTANCES=${_MIN_INSTANCES}\
	---_PORT=${_PORT}\
	---_PROJECT=${_PROJECT}\
	---_REGION=${_REGION}\
	---_SERVICE_ACCOUNT=${_SERVICE_ACCOUNT}\
	---_SERVICE_NAME=${_SERVICE_NAME}\
	---_SERVICE=${_SERVICE}\
	---_TARGET=${_TARGET}\
	---_TIMEOUT=${_TIMEOUT}\
	---_USER=${_USER}\
	---_WORK_DIR=${_WORK_DIR}


.PHONY: check_files_for_upload
check_files_for_upload:
	gcloud meta list-files-for-upload
