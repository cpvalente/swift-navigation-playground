import SwiftUI

struct ContentView: View {
    @State private var loggedIn = false
    var body: some View {
            if (loggedIn) {
                AppRouter()
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

// AppRouter would receive the initial router for deeplink
struct AppRouter: View {
    @State var path = [String](["cc"])
    @State var resolver: TabItems = TabItems.photos
    
    init() {
        path.append("aa")
        print("init thing \(path)")
    }
    
    // albums/id
    var body: some View {
        Tabs(resolver: $resolver, path: path)
            .onAppear(perform: {
            //path.append("bb")
            print("append thing \(path)")

        })
            .onOpenURL { url in
                path.removeAll()
                path.append("dd")
            }
    }
    
}
