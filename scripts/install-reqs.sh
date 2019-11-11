#!/bin/bash

set -x
set -e
set -o pipefail

venv/bin/pip3 install -r requirements.txt
