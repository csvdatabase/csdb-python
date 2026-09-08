# CSDB Python Library

> **Start here:** Project-wide information, planning, and community resources live in the [main CSDB repository](https://github.com/csvdatabase/csdb).

## Introduction

This repository is reserved for the native Python implementation of CSDB. The library has not been implemented yet.

## Releasing

Run releases from this repository only:

```bash
make release version=1.1.1
```

The command creates a repo-local GitHub Release. Published GitHub Releases run
`.github/workflows/release.yml`, which validates the tag and publishes the Python
package to PyPI.

Major releases use `x.0.0` and must be cut from a matching major branch. For
example, `make release version=1.0.0` must be run from branch `v1`.
