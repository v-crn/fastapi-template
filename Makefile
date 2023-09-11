include .env
include dotenvs/.env.dev

include makefiles/cloudbuild/cloudbuild.dev.mk
include makefiles/configs/config.dev.mk
include makefiles/configs/config.mk
include makefiles/api.mk
include makefiles/docker.mk
include makefiles/formatter.mk
include makefiles/test.mk
