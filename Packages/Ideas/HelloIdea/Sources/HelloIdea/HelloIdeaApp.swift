import IdeaKit
import SwiftUI

/// サンプルの最初のアイデア。新しいIdeaを作るときのテンプレート代わり。
public enum HelloIdeaApp: IdeaApp {
    public static let name = "Hello Idea"

    public static func makeRootView() -> AnyView {
        AnyView(HelloIdeaView())
    }
}

@Observable
final class HelloIdeaModel {
    var count = 0

    func increment() {
        count += 1
    }
}

struct HelloIdeaView: View {
    @State private var model = HelloIdeaModel()

    var body: some View {
        VStack(spacing: 24) {
            Text("👋 Hello, Idea!")
                .font(.title)

            Text("\(model.count)")
                .font(.system(size: 48, weight: .bold, design: .rounded))

            Button("Tap me") {
                model.increment()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle(HelloIdeaApp.name)
    }
}

#Preview {
    HelloIdeaView()
}
