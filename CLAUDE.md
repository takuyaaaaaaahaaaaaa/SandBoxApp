# SandBoxApp

個人開発のアイデアを素早く試作 → TestFlightで動作確認するための"器"アプリ。

## ディレクトリ構成

```
SandBoxApp/
├── project.yml            ← XcodeGenの定義ファイル。編集後は `xcodegen generate`
├── SandBoxApp/             ← App Target本体(ランチャー画面のみ)
├── Packages/
│   ├── Core/               ← 共通基盤(今は空)
│   ├── IdeaKit/            ← IdeaApp プロトコルのみ
│   └── Ideas/
│       └── HelloIdea/      ← サンプルIdea。新規Idea作成時のテンプレート
├── ci_scripts/             ← Xcode Cloud用(ci_post_clone.shがxcodegen generateを実行)
└── scripts/add-idea.sh     ← 新規Idea追加を自動化するスクリプト
```

## アーキテクチャ

- MV パターン(`@Observable` な Model + SwiftUI View)のみ。ViewModel/Reducer/TCAは使わない
- 各 `Ideas/*` パッケージは他の `Ideas/*` に依存しない。依存してよいのは `IdeaKit` と `Core` のみ
- `IdeaKit.IdeaApp` プロトコルに準拠すればランチャーに追加できる

## 新しいIdeaの追加方法

```bash
./scripts/add-idea.sh MyNewIdea
```

これで以下が自動的に行われる:
1. `Packages/Ideas/HelloIdea` を `Packages/Ideas/MyNewIdea` としてコピー
2. `project.yml` にパッケージ定義とapp targetの依存関係を追記
3. `SandBoxApp/LauncherView.swift` の `allIdeas` 配列に1行追加

あとは `Packages/Ideas/MyNewIdea/Sources/MyNewIdea` の中身を書き換えるだけ。

## ビルド・テスト

```bash
xcodegen generate   # project.yml を変更したら必須
xcodebuild -project SandBoxApp.xcodeproj -scheme SandBoxApp \
  -destination 'generic/platform=iOS Simulator' build
```

## CI/CD

Xcode Cloud。署名はXcode Cloud管理下のCloud Signingを使用しており、fastlane matchや手動プロビジョニングは不要。
