# Development

Here you'll find a contributing guide to get started with development.

## Environment

For local development, it is required to have Python 3.10 (or a later version) installed.

We use [uv](https://docs.astral.sh/uv/) for project management. Install it and set up your IDE accordingly.

## Dependencies

To install this package and its development dependencies, run:

```sh
make install-dev
```

## Code checking

To execute all code checking tools together, run:

```sh
make check-code
```

### Linting

We utilize [ruff](https://docs.astral.sh/ruff/) for linting, which analyzes code for potential issues and enforces consistent style. Refer to `pyproject.toml` for configuration details.

To run linting:

```sh
make lint
```

### Formatting

Our automated code formatting also leverages [ruff](https://docs.astral.sh/ruff/), ensuring uniform style and addressing fixable linting issues. Configuration specifics are outlined in `pyproject.toml`.

To run formatting:

```sh
make format
```

### Type checking

Type checking is handled by [mypy](https://mypy.readthedocs.io/), verifying code against type annotations. Configuration settings can be found in `pyproject.toml`.

To run type checking:

```sh
make type-check
```

### Unit tests

We employ pytest as our testing framework, equipped with various plugins. Check pyproject.toml for configuration details and installed plugins.

We use [pytest](https://docs.pytest.org/) as a testing framework with many plugins. Check `pyproject.toml` for configuration details and installed plugins.

To run unit tests:

```sh
make unit-tests
```

To run unit tests with HTML coverage report:

```sh
make unit-tests-cov
```

## Integration tests

We have integration tests which build and run Actors using the Python SDK on the Apify Platform. To run these tests,
you need to set the `APIFY_TEST_USER_API_TOKEN` environment variable to the API token of the Apify user you want to
use for the tests, and then start them with `make integration-tests`.

If you want to run the integration tests on a different environment than the main Apify Platform, you need to set
the `APIFY_INTEGRATION_TESTS_API_URL` environment variable to the right URL to the Apify API you want to use.

## Documentation

We adhere to the [Google docstring format](https://sphinxcontrib-napoleon.readthedocs.io/en/latest/example_google.html) for documenting our codebase. Every user-facing class or method is documented. Documentation standards are enforced using [Ruff](https://docs.astral.sh/ruff/).

Our API documentation is generated from these docstrings using [pydoc-markdown](https://pypi.org/project/pydoc-markdown/) with additional post-processing. Markdown files in the `docs/` folder complement the autogenerated content. Final documentation is rendered using [Docusaurus](https://docusaurus.io/) and published to GitHub Pages.

To run the documentation locally, you need to have Node.js version 20 or higher installed. Once you have the correct version of Node.js, follow these steps:

Navigate to the `website/` directory:

```sh
cd website/
```

Enable Corepack, which installs Yarn automatically:

```sh
corepack enable
```

Build the API reference:

```sh
./build_api_reference.sh
```

Install the necessary dependencies:

```sh
yarn
```

Start the project in development mode with Hot Module Replacement (HMR):

```sh
yarn start
```

Or using `make`:

```sh
make run-doc
```

## Release process

Publishing new versions to [PyPI](https://pypi.org/project/apify_client) is automated through GitHub Actions.

- **Beta releases**: On each commit to the master branch, a new beta release is automatically published. The version number is determined based on the latest release and conventional commits. The beta version suffix is incremented by 1 from the last beta release on PyPI.
- **Stable releases**: A stable version release may be created by triggering the `release` GitHub Actions workflow. The version number is determined based on the latest release and conventional commits (`auto` release type), or it may be overriden using the `custom` release type.

### Publishing to PyPI manually

1. **Do not do this unless absolutely necessary.** In all conceivable scenarios, you should use the `release` workflow instead.
2. **Make sure you know what you're doing.**

3. Update the version number:

- Modify the `version` field under `project` in `pyproject.toml`.

```toml
[project]
name = "apify_client"
version = "x.z.y"
```

4. Generate the distribution archives for the package:

```shell
uv build
```

5. Set up the PyPI API token for authentication and upload the package to PyPI:

```shell
uv publish --token YOUR_API_TOKEN
```
