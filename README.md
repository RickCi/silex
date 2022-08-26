# Silex

[![Python](https://img.shields.io/badge/Python3.8-Python?style=for-the-badge&logo=Python)](https://www.python.org/downloads/release/python-380/)
![Apache Spark](https://img.shields.io/static/v1?style=for-the-badge&message=Apache+Spark&color=E25A1C&logo=Apache+Spark&logoColor=FFFFFF&label=)

[![Linter](https://img.shields.io/badge/Codestyle-Black-black?style=for-the-badge)](https://github.com/psf/black)

Silex adds more sparks to your project!

## TLDR

Silex is a Data Engineering library to extend PySpark.

## Getting started

### Pre-requisites

- Python 3.8 or above
- Spark 3.2 or above

### Installation

`# TODO`

### Usage

```python
# TODO
```

## Contributing

```shell
# install poetry and python 3.8, using pyenv for instance

cd silex
poetry install
poetry shell
pre-commit install

make help
# or open Makefile to learn about available commands for development
```

We use:

- [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
- [git pre-commit](https://pre-commit.com/) to increase code quality before committing
- `Squashed Pull Request` or `Rebased Pull Request` (not too many commits)
- [doc-tests](https://docs.python.org/3/library/doctest.html) for simple or pure functions
- Behavior-driven development (BDD) using [behave](https://github.com/behave/behave) for non-doc-tests
