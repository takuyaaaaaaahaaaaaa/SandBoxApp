import IdeaKit
import SwiftUI

/// サンプルの最初のアイデア。新しいIdeaを作るときのテンプレート代わり。
public enum HelloIdeaApp: IdeaApp {
    public static let name = "Hello Idea"

    public static func makeRootView() -> AnyView {
        AnyView(HelloIdeaRootView())
    }
}

/// このIdeaが選択されたときに画面全体のルートになるView。
/// TabViewを丸ごとルートにできる例として、Counter/Aboutの2タブを持たせている。
/// Aboutタブにランチャーへ戻るボタンを置いている。
struct HelloIdeaRootView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HelloIdeaCounterView()
            }
            .tabItem {
                Label("Counter", systemImage: "hand.tap")
            }

            NavigationStack {
                HelloIdeaAboutView()
            }
            .tabItem {
                Label("About", systemImage: "info.circle")
            }
        }
    }
}

@Observable
final class HelloIdeaModel {
    var count = 0

    func increment() {
        count += 1
    }
}

struct HelloIdeaCounterView: View {
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

struct HelloIdeaAboutView: View {
    @Environment(\.returnToLauncher) private var returnToLauncher

    var body: some View {
        VStack(spacing: 16) {
            Text("HelloIdeaはIdeaKitを使ったサンプルです。")
                .multilineTextAlignment(.center)

            Button("Sandboxに戻る") {
                returnToLauncher()
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .navigationTitle("About")
    }
}

#Preview {
    HelloIdeaRootView()
}
