import SwiftUI

struct Me: View {
    @Binding var initialPath: [any Hashable]
    @StateObject var router = NavigationStore()

    var body: some View {
        NavigationStack {
            NavigationLink("Settings") {
                Settings()
            }.navigationTitle("me")
                .toolbar {
                    Button(action: {}) {
                        Image(systemName: "gearshape")
                    }
                }
        }.onChange(of: router.path) { newValue in
            print("me: path changed \(newValue)")
        }
    }
}

/*
struct Me_Previews: PreviewProvider {
    static var previews: some View {
        Me()
    }
}

*/
