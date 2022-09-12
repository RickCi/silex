SHELL := /bin/bash
.PHONY : all

SOURCE_CODE = src
SOURCE_CODE_MAIN = src/silex
SOURCE_CODE_TEST = src/tests
SOURCE_CODE_TEST_BDD = src/tests/bdd
COVERAGE_FAIL_UNDER = 90

########
# CD   #
########

publish:
	semantic-release publish -D commit_author="rci <rci-git@pm.me>"

########
# DEV  #
########

help:
	cat Makefile

# run all checks
pre_commit_force:
	pre-commit run --all-files

# format code
fmt:
	python -m black $(SOURCE_CODE) examples
	python -m isort --profile black $(SOURCE_CODE) examples

# run all tests
test: test_static test_coverage

test_bdd:
	python -m behave $(SOURCE_CODE_TEST_BDD)

test_bdd_wip:
	python -m behave $(SOURCE_CODE_TEST_BDD) --no-capture --wip --color

test_static:
	python -m black --check $(SOURCE_CODE)
	python -m isort --profile black --check $(SOURCE_CODE)
	python -m flake8 $(SOURCE_CODE)
	python -m bandit -r $(SOURCE_CODE_MAIN) --exclude $(SOURCE_CODE_TEST)
	# python -m safety check  # licensed for non-commercial use or provide your API key with --key
	python -m mypy $(SOURCE_CODE) --exclude $(SOURCE_CODE_TEST) --explicit-package-bases --namespace-packages --ignore-missing-imports --show-error-codes

test_coverage:
	python -m coverage run --source=$(SOURCE_CODE_MAIN) -m pytest --disable-pytest-warnings -x -s $(SOURCE_CODE_MAIN) --doctest-modules
	python -m coverage run --source=$(SOURCE_CODE_MAIN) --append -m behave $(SOURCE_CODE_TEST_BDD)
	python -m coverage report --show-missing --fail-under=$(COVERAGE_FAIL_UNDER)
	python -m coverage html -d coverage_html
	python -m coverage xml -o coverage-reports/coverage-ci.xml
