import SwiftUI

struct Me: View {
    @EnvironmentObject var router: Router

    var body: some View {
        NavigationStack(path: $router.mePath) {
            NavigationLink("Settings") {
                Settings()
            }.navigationTitle("me")
                .toolbar {
                    Button(action: {}) {
                        Image(systemName: "gearshape")
                    }
                }
        }.onChange(of: router.mePath) { newValue in
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
