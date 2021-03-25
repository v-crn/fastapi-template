.PHONY: fmt
fmt:
	isort .
	autoflake -ri --remove-all-unused-imports --ignore-init-module-imports --remove-unused-variables .
	black --exclude .venv .

.PHONY: unsd
unsd:
	vulture --min-confidence=70 --exclude .venv .

.PHONY: jupyterlab
jupyterlab:
	jupyter lab --allow-root --ip 0.0.0.0
