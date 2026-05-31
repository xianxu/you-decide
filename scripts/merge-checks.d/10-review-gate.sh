#!/usr/bin/env bash
# you-decide publish-gate plugin (issue #4 M3): shared substrate must be
# `review: passed`. Wraps scripts/review-gate.sh; receives <base> <head> from
# the runner (CI over the PR range, or the local pre-push hook).
exec "$(git rev-parse --show-toplevel)/scripts/review-gate.sh" "$@"
