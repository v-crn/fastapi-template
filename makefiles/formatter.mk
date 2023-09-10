.PHONY: lint
lint:
	pflake8 ${PACKAGE_NAME} tests
	mypy ${PACKAGE_NAME} tests


.PHONY: format
format:
	black --exclude=.venv ${PACKAGE_NAME} tests
	autoflake -ri --remove-all-unused-imports --ignore-init-module-imports --remove-unused-variables ${PACKAGE_NAME} tests
	isort --profile=black ${PACKAGE_NAME} tests

.PHONY: unsd
unsd:
	vulture --min-confidence=70 --exclude .venv .
