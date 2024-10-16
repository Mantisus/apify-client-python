.PHONY: clean install-dev build publish-to-pypi lint type-check unit-tests unit-tests-cov \
        integration-tests format check-code check-async-docstrings fix-async-docstrings \
        check-version-availability check-changelog-entry check-version-conflict build-api-reference \
        run-docs

DIRS_WITH_CODE = src tests scripts

# This is default for local testing, but GitHub workflows override it to a higher value in CI
INTEGRATION_TESTS_CONCURRENCY = 1

clean:
	rm -rf .mypy_cache .pytest_cache .ruff_cache build dist htmlcov .coverage

install-dev:
	poetry install --all-extras
	poetry run pre-commit install

build:
	poetry build --no-interaction -vv

# APIFY_PYPI_TOKEN_CRAWLEE is expected to be set in the environment
publish-to-pypi:
	poetry config pypi-token.pypi "${APIFY_PYPI_TOKEN_CRAWLEE}"
	poetry publish --no-interaction -vv

lint:
	poetry run ruff format --check $(DIRS_WITH_CODE)
	poetry run ruff check $(DIRS_WITH_CODE)

type-check:
	poetry run mypy $(DIRS_WITH_CODE)

unit-tests:
	poetry run pytest --numprocesses=auto --verbose --cov=src/apify_client tests/unit

unit-tests-cov:
	poetry run pytest --numprocesses=auto --verbose --cov=src/apify_client --cov-report=html tests/unit

integration-tests:
	poetry run pytest --numprocesses=$(INTEGRATION_TESTS_CONCURRENCY) tests/integration

format:
	poetry run ruff check --fix $(DIRS_WITH_CODE)
	poetry run ruff format $(DIRS_WITH_CODE)

check-async-docstrings:
	poetry run python scripts/check_async_docstrings.py

check-changelog-entry:
	poetry run python scripts/check_changelog_entry.py

check-version-conflict:
	poetry run python scripts/check_version_conflict.py

# The check-code target runs a series of checks equivalent to those performed by pre-commit hooks
# and the run_checks.yaml GitHub Actions workflow.
check-code: lint type-check unit-tests check-async-docstrings check-changelog-entry check-version-conflict

fix-async-docstrings:
	poetry run python scripts/fix_async_docstrings.py

build-api-reference:
	cd website && poetry run ./build_api_reference.sh

build-docs:
	cd website && npm clean-install && npm run build

run-docs: build-api-reference
	cd website && npm clean-install && npm run start
