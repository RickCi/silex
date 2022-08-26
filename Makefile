SHELL := /bin/bash
.PHONY : all

help:
	cat Makefile

# run all checks
pre_commit_force:
	pre-commit run --all-files

format_code:
	python -m black src
	python -m isort --profile black src

# run all tests
test: test_static test_coverage

test_bdd:
	python -m behave src/tests/bdd

test_bdd_wip:
	python -m behave src/tests/bdd --no-capture --wip

test_static:
	python -m black --check src
	python -m isort --profile black --check src
	python -m flake8 src
	python -m bandit -r src/silex --exclude src/tests
	python -m safety check
	python -m mypy src --exclude src/tests --explicit-package-bases --namespace-packages --ignore-missing-imports --show-error-codes

test_coverage:
	python -m coverage run --source=src/silex -m pytest --disable-pytest-warnings -x -s src/silex --doctest-modules
	python -m coverage run --source=src/silex --append -m behave src/tests/bdd
	python -m coverage report --show-missing --fail-under=95
	python -m coverage html -d coverage_html
	python -m coverage xml -o coverage-reports/coverage-ci.xml
