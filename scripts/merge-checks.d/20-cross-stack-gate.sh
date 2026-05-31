#!/usr/bin/env bash
# you-decide cross-stack-gate plugin (#4 M2 / ariadne #53 Phase D): a passed
# shared-substrate review must be cross-stack (reviewed-by ≠ generated-by).
# Wraps scripts/cross-stack-gate.sh; receives <base> <head> from the runner
# (CI over the PR range, or the local pre-push hook). Runs after 10-review-gate.
exec "$(git rev-parse --show-toplevel)/scripts/cross-stack-gate.sh" "$@"
