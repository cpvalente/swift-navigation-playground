import SwiftUI


// the protocol establishes base behaviour to be implemented
protocol Destination: Hashable {
    var id: String {get}
}

struct Photo: Identifiable, Destination {
    let id: String
}

let timelinePhotos: [Photo] = [
    Photo(id: "photo 1"),
    Photo(id: "photo 2"),
    Photo(id: "photo 3"),
    Photo(id: "photo 4"),
    Photo(id: "photo 5"),
    Photo(id: "photo 6"),
    Photo(id: "photo 7"),
    Photo(id: "photo 8"),
    Photo(id: "photo 9"),
]

struct Album: Identifiable, Destination {
    let id: String
    let name: String
}

let albumList: [Album] = [
    Album(id: "album 1", name: "Album 1"),
    Album(id: "album 2", name: "Album 2"),
    Album(id: "album 3", name: "Album 3"),
    Album(id: "album 4", name: "Album 4"),
    Album(id: "album 5", name: "Album 5"),
    Album(id: "album 6", name: "Album 6"),
    Album(id: "album 7", name: "Album 7"),
    Album(id: "album 8", name: "Album 8"),
    Album(id: "album 9", name: "Album 9"),
]

struct Carousel: Destination {
    let id: String
    let photos: [String]
}

final class NavigationStore: ObservableObject {
    @Published var path = NavigationPath() // ["albums", "photo-id", "showModal"]
    
    init(initialPath: [any Destination] = []) {
        self.path = NavigationPath()
    }
    
    func append(destination: any Destination) {
        self.path.append(destination)
    }
    
    func clear() {
        self.path = NavigationPath()
    }
}

struct ContentView: View {
    @State private var loggedIn = false
    @State var initialTab = getInitialTab()

    var body: some View {
        if (loggedIn) {
            Tabs(initialTab: $initialTab)
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

/**
    Initial tab resolves the top level destination of the app considering:
    1. The last session state
    2. A potential deeplink
 */
func getInitialTab() -> TabItem {
    return TabItem.me
}

/*
 struct AppRouter: View {
 
 var body: some View {
 /*
  .onAppear(perform: {
  router.append(tab: TabItem.albums, destination: albumList[0])
  router.append(tab: TabItem.albums, destination: Photo.init(id: albumPhotos[2].id))
  print("append on router \(router.path)")
  })
  .onOpenURL { url in
  router.clear()
  router.append(tab: TabItem.albums, destination: albumList[1])
  router.append(tab: TabItem.albums, destination: Photo.init(id: albumPhotos[3].id))
  }
  .environmentObject(router)
  */
 }
 }
 */
