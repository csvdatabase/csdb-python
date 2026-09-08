#!/usr/bin/env bash
# RELEASE_TAG=v1.0.0 TARGET_COMMITISH=v1 bash scripts/verify-release.sh

set -euo pipefail
cd "$(dirname "$0")/.."
tag="${RELEASE_TAG:?}"
target="${TARGET_COMMITISH:?}"
[[ "$tag" =~ ^v(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$ ]] || { echo "Invalid release tag" >&2; exit 1; }
branch="v${BASH_REMATCH[1]}"
[[ "$target" == "$branch" ]] || { echo "Release $tag must target $branch" >&2; exit 1; }
version=$(python3 -c 'import tomllib; print(tomllib.load(open("pyproject.toml", "rb"))["project"]["version"])')
[[ "$tag" == "v$version" ]] || { echo "Tag must match package version" >&2; exit 1; }
[[ "$version" == "$(python3 -c 'import runpy; print(runpy.run_path("src/csdb/__init__.py")["__version__"])')" ]] || { echo "Python package versions must match" >&2; exit 1; }
git fetch origin "refs/heads/$branch:refs/remotes/origin/$branch"
git merge-base --is-ancestor HEAD "refs/remotes/origin/$branch"
