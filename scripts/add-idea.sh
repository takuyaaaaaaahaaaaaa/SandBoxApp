#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "使い方: $0 <IdeaName>  (例: $0 CameraFilter)" >&2
  exit 1
fi

NAME="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TEMPLATE_DIR="${ROOT}/Packages/Ideas/HelloIdea"
NEW_DIR="${ROOT}/Packages/Ideas/${NAME}"

if [ -d "${NEW_DIR}" ]; then
  echo "error: ${NEW_DIR} は既に存在します" >&2
  exit 1
fi

echo "1/4 HelloIdea をテンプレートとしてコピー中..."
cp -R "${TEMPLATE_DIR}" "${NEW_DIR}"
mv "${NEW_DIR}/Sources/HelloIdea" "${NEW_DIR}/Sources/${NAME}"
mv "${NEW_DIR}/Sources/${NAME}/HelloIdeaApp.swift" "${NEW_DIR}/Sources/${NAME}/${NAME}App.swift"
find "${NEW_DIR}" -type f -name "*.swift" -exec sed -i '' "s/HelloIdea/${NAME}/g" {} +

echo "2/4 project.yml にパッケージ定義を追加中..."
sed -i '' "/  HelloIdea:/i\\
  ${NAME}:\\
    path: Packages/Ideas/${NAME}
" "${ROOT}/project.yml"

echo "3/4 project.yml のapp target依存関係に追加中..."
sed -i '' "/      - package: HelloIdea/a\\
      - package: ${NAME}
" "${ROOT}/project.yml"

echo "4/4 LauncherView.swift の allIdeas に追加中..."
sed -i '' "s/^import HelloIdea/import HelloIdea\\
import ${NAME}/" "${ROOT}/SandBoxApp/LauncherView.swift"
sed -i '' "s/    HelloIdeaApp.self/    HelloIdeaApp.self,\\
    ${NAME}App.self/" "${ROOT}/SandBoxApp/LauncherView.swift"

echo ""
echo "完了。次を実行してビルド確認してください:"
echo "  xcodegen generate"
echo "  xcodebuild -project SandBoxApp.xcodeproj -scheme SandBoxApp -destination 'generic/platform=iOS Simulator' build"
