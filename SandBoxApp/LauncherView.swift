import HelloIdea
import IdeaKit
import SwiftUI

/// 新しいIdeaを追加するときはここに1行足すだけでよい。
private let allIdeas: [any IdeaApp.Type] = [
    HelloIdeaApp.self
]

struct LauncherView: View {
    var body: some View {
        NavigationStack {
            List(allIdeas.indices, id: \.self) { index in
                let idea = allIdeas[index]
                NavigationLink(idea.name, value: index)
            }
            .navigationTitle("Sandbox")
            .navigationDestination(for: Int.self) { index in
                allIdeas[index].makeRootView()
            }
        }
    }
}

#Preview {
    LauncherView()
}
