# Private repository setup

## Private repository

### ⚠️️ Name squatting ⚠️️

To prevent name squatting of package name, e.g. to prevent downloading a malicious package X from public repository
instead of your package X on your private repo, one way is to target your private repository and have it proxy public ones.

Otherwise, make sure to target your private repository when downloading your own package whether you use `pip` or `poetry`.

## Using poetry

[https://python-poetry.org/docs/repositories/#using-a-private-repository](https://python-poetry.org/docs/repositories/#using-a-private-repository)

Your `pyproject.toml` should now have:

```toml
[[tool.poetry.source]]
name = "<repo name>"
url = "<url to repository>"
```

Check your poetry configuration file: [https://python-poetry.org/docs/configuration/](https://python-poetry.org/docs/configuration/)

- On linux: `~/.config/pypoetry/auth.toml`
- On MacOS: `~/Library/Application Support/pypoetry/auth.toml`
- On Windows: `C:\Users\<username>\AppData\Roaming\pypoetry\auth.toml`

Then use `poetry add` as usual.

## Downloading packages from a private repository

To be able to download packages from a remote repository, you will need to update `pip` configuration file.

- On linux: `~/.pip/pip.conf`

```
[global]
extra-index-url = https://<username>:<password>@<url to repository>
```

Then you should be able to run `pip install X`.

## Uploading packages to a private repository

### Setup

[https://packaging.python.org/en/latest/specifications/pypirc/](https://packaging.python.org/en/latest/specifications/pypirc/)

- On linux the file is at `~/.pypirc`

```
[distutils]
index-servers =
    <repo name>

[<repo name>]
repository: <url to repository>
username: <your username>
password: <your password>
```

### Usage

```shell
# cd <your project root directory>
rm -rfI dist/
poetry build
python -m twine upload --repository <repo name> dist/*
```

## pypirc vs pip.conf

[https://stackoverflow.com/a/51525463](https://stackoverflow.com/a/51525463)
