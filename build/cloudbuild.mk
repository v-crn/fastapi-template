.PHONY build_dev:
build_dev:
	gcloud builds submit --config build/dev/cloudbuild.dev.yaml

.PHONY build_prd:
build_prd:
	gcloud builds submit --config build/prd/cloudbuild.yaml
