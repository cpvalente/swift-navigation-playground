import SwiftUI

struct Login: View {
    @Binding var loggedIn: Bool

    var body: some View {
        VStack {
            NavigationLink("Settings") {
                Settings()
            }
            Button("Log in") {
                loggedIn.toggle()
            }
        }
    }
}
