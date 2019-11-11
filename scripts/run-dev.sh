#!/bin/bash

set -x
set -e
set -o pipefail

export $(cat configs/dev.env | xargs)

venv/bin/python3 appserver.py
