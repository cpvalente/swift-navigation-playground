import SwiftUI


class NavigationStore: ObservableObject {
    @Published var path = NavigationPath()
    @Published var resolver: TabItems = TabItems.photos
    
    init(initialPath: String = "", initialTab: TabItems = TabItems.photos ) {
        self.path = NavigationPath(initialPath)
        self.resolver = initialTab
    }
    
    func append(tab: TabItems, destination: any Hashable) {
        self.path.append(destination)
        self.resolver = tab
    }
    
    func clear() {
        self.path = NavigationPath()
    }
}

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
    @StateObject var router = NavigationStore()
    
   
    // albums/id
    var body: some View {
        Tabs()
            .onAppear(perform: {
            router.append(tab: TabItems.photos, destination: "bb")
            print("append thing \(router.path)")
        })
            .onOpenURL { url in
                router.clear()
                router.append(tab: TabItems.albums, destination: "dd")
            }
            .environmentObject(router)
    }
    
}
