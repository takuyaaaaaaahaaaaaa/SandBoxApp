import SwiftUI

/// ランチャーから起動できる「1つのアイデア」が実装すべきプロトコル。
///
/// 各Ideaパッケージはこれだけに準拠すればランチャー一覧に追加できる。
public protocol IdeaApp {
    static var name: String { get }
    static func makeRootView() -> AnyView
}
