# CONTRIBUTING

## Quicklinks

- [CONTRIBUTING](#contributing)
  - [Quicklinks](#quicklinks)
  - [Getting Started](#getting-started)
    - [Issues](#issues)
    - [Pull Requests](#pull-requests)
  - [Contributing to project](#contributing-to-project)
    - [Documentation](#documentation)
    - [Assets compilation](#assets-compilation)
    - [Environment setup](#environment-setup)
  - [Testing](#testing)
    - [Adding tests](#adding-tests)
    - [Running tests](#running-tests)
  - [Code quality tools](#code-quality-tools)
  - [CI Information](#ci-information)
  - [Repo-specific PR guidelines](#repo-specific-pr-guidelines)
  - [Code of Conduct](#code-of-conduct)
  - [Getting Help](#getting-help)

## Getting Started

Contributions are made to this repo via Issues and Pull Requests (PRs). A few general guidelines that cover both:

- To report security vulnerabilities, please use our [SECURITY](/.github/SECURITY.md) which is monitored by our security team.
- Search for existing Issues and PRs before creating your own.
- We work hard to makes sure issues are handled in a timely manner but, depending on the impact, it could take a while to investigate the root cause. A friendly ping in the comment thread to the submitter or a contributor can help draw attention if your issue is blocking.

### Issues

Issues should be used to report problems with the library, request a new feature, or to discuss potential changes before a PR is created. When you create a new Issue, a template will be loaded that will guide you through collecting and providing the information we need to investigate.

If you find an Issue that addresses the problem you're having, please add your own reproduction information to the existing issue rather than creating a new one. Adding a reaction can also help be indicating to our maintainers that a particular problem is affecting more than just the reporter.

### Pull Requests

PRs to our libraries are always welcome and can be a quick way to get your fix or improvement slated for the next release. In general, PRs should:

- Only fix/add the functionality in question **OR** address wide-spread whitespace/style issues, not both.
- Add unit or integration tests for fixed or changed functionality (if a test suite already exists).
- Address a single concern in the least number of changed lines as possible.
- Include documentation in the repo or on our [DOCS](README.md).
- Be accompanied by a complete Pull Request template (loaded automatically when a PR is created).

For changes that address core functionality or would require breaking changes (e.g. a major release), it's best to open an Issue to discuss your proposal first. This is not required but can save time creating and reviewing changes.

1. Fork the repository to your own Github account
2. Clone the project to your machine
3. Create a branch locally with a succinct but descriptive name
4. Commit changes to the branch
5. Following any formatting and testing guidelines specific to this repo
6. Push changes to your fork
7. Open a PR in our repository and follow the PR template so that we can efficiently review the changes.

## Contributing to project

A big welcome and thank you for considering contributing to open source projects! It’s people like you that make it a reality for users in our community.

Reading and following these guidelines will help us make the contribution process easy and effective for everyone involved. It also communicates that you agree to respect the time of the developers managing and developing these open source projects. In return, we will reciprocate that respect by addressing your issue, assessing changes, and helping you finalize your pull requests.

### Documentation

- PR for docs site update, if needed
- Code-level documentation expectations
  - 100% documentation coverage for PRs
  - Include links to relevant project docs pages

### Assets compilation

Information about compiling CSS, JS, SVG, etc.

### Environment setup

Link to [README > setup](README.md#setup) steps and include anything additional needed to contribute to the project.

## Testing

### Adding tests

General information about the test suite and how to format and structure tests.

### Running tests

Any additional information needed to run the test suite. Include `bash` commands like:

```bash
make test
```

Also include any information about essential manual tests.

## Code quality tools

Information about scripts to run before committing.

## CI Information

What CI checks for and how to pass.

## Repo-specific PR guidelines

Anything not covered in the general guidelines linked above.

## Code of Conduct

We take our open source community seriously and hold ourselves and other contributors to high standards of communication. By participating and contributing to this project, you agree to uphold our [Code of Conduct](/.github/CODE_OF_CONDUCT.md).

## Getting Help

Join us in the [Community](https://github.com/gurayalinn/guray.me/discussions) and post your question there in the correct category with a descriptive tag.
