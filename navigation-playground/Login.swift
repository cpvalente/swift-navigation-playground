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

struct Login_Previews: PreviewProvider {
    @State private var loggedIn: Bool = false

    static var previews: some View {
        Login(loggedIn: .constant(false))
    }
}
