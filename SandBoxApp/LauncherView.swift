import SwiftUI

struct LauncherView: View {
    @Binding var selectedIndex: Int?

    var body: some View {
        NavigationStack {
            List(allIdeas.indices, id: \.self) { index in
                let idea = allIdeas[index]
                Button(idea.name) {
                    selectedIndex = index
                }
            }
            .navigationTitle("Sandbox")
        }
    }
}

#Preview {
    LauncherView(selectedIndex: .constant(nil))
}
