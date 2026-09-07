#!/usr/bin/env python3
import re
import sys
from pathlib import Path

if len(sys.argv) != 2:
    raise SystemExit("usage: scripts/set-version.py 1.1.1")

version = sys.argv[1]
if not re.fullmatch(r"[0-9]+\.[0-9]+\.[0-9]+", version):
    raise SystemExit("version must be semver like 1.1.1")

pyproject = Path("pyproject.toml")
text = pyproject.read_text(encoding="utf-8")
text = re.sub(r'^version = "[^"]+"', f'version = "{version}"', text, flags=re.M)
pyproject.write_text(text, encoding="utf-8")

init = Path("src/csdb/__init__.py")
text = init.read_text(encoding="utf-8")
text = re.sub(r'__version__ = "[^"]+"', f'__version__ = "{version}"', text)
init.write_text(text, encoding="utf-8")
