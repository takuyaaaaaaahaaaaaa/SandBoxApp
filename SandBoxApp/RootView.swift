import HelloIdea
import IdeaKit
import SwiftUI

/// 新しいIdeaを追加するときはここに1行足すだけでよい。
let allIdeas: [any IdeaApp.Type] = [
    HelloIdeaApp.self
]

/// 選択中のIdeaがあれば、その `makeRootView()` を画面全体のルートとして丸ごと表示する。
/// モーダルでかぶせるのではなく置き換えるので、Idea側はTabViewなど自由な構造を組める。
struct RootView: View {
    @State private var selectedIndex: Int?

    var body: some View {
        if let selectedIndex {
            allIdeas[selectedIndex].makeRootView()
                .environment(\.returnToLauncher) {
                    self.selectedIndex = nil
                }
        } else {
            LauncherView(selectedIndex: $selectedIndex)
        }
    }
}

#Preview {
    RootView()
}
