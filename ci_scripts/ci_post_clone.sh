#!/usr/bin/env bash
set -euo pipefail

# Xcode Cloud はコミットされた .xcodeproj でワークフローを組むため、
# クローン直後に project.yml から常に最新の状態へ再生成しておく。
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

brew install xcodegen

cd "${PROJECT_ROOT}"
xcodegen generate
