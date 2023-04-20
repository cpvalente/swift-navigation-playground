import SwiftUI

struct ContentView: View {
    @State private var loggedIn = false
    var body: some View {
            if (loggedIn) {
                Tabs()
            } else {
                NavigationStack {
                    Login(loggedIn: $loggedIn)
                }
             }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
