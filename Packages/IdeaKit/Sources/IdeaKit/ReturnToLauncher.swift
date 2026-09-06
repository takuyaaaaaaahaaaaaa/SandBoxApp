import SwiftUI

/// Ideaの画面からSandboxのランチャーへ戻るためのアクション。
///
/// ランチャーがルートを丸ごとIdeaの画面に差し替える設計のため、
/// 「戻る」ボタンはナビゲーションスタックの外側にある。Idea側はTabViewの
/// 好きな場所(設定タブなど)にこの `returnToLauncher()` を呼ぶボタンを置けばよい。
private struct ReturnToLauncherKey: EnvironmentKey {
    static let defaultValue: @Sendable () -> Void = {}
}

extension EnvironmentValues {
    public var returnToLauncher: @Sendable () -> Void {
        get { self[ReturnToLauncherKey.self] }
        set { self[ReturnToLauncherKey.self] = newValue }
    }
}
