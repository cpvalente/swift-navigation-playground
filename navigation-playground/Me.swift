import SwiftUI

struct Me: View {
    @EnvironmentObject var router: NavigationStore
    
    var body: some View {
        NavigationStack() {
            VStack {
                NavigationLink("Settings") {
                    Settings()
                }
                .padding()
                Image(systemName: "bell")
                  .foregroundColor(Color.blue)
                  .overlay(
                    NotificationCountView(
                      value: .constant(9),
                      foreground: .white,
                      background: .green
                    )
                  )
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
