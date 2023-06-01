import SwiftUI


// the protocol establishes base behaviour to be implemented
struct Photo: Identifiable, Hashable {
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

struct Album: Identifiable, Hashable {
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

struct Carousel: Hashable {
    let id: String
    let photos: [String]
}

enum PathInStore {
    case me, photo, album, all
}

final class NavigationStore: ObservableObject {
    @Published var selectedTab: TabItem = TabItem.me
    @Published var mePath = NavigationPath()
    @Published var photoPath = NavigationPath()
    @Published var albumPath = NavigationPath()
    
    init(initialPath: [any Hashable] = []) {
        if (true) {
            self.selectedTab = TabItem.albums
        }
        
        if (true) {
            albumPath.append(albumList[0])
            albumPath.append(Photo.init(id: albumPhotos[3].id))
        }
    }
    
    func append(path: PathInStore, destination: any Hashable) {
        self.mePath.append(destination)
    }
    
    func clear() {
        self.mePath = NavigationPath()
    }
    
    func resolveDeepLink() {
        self.selectedTab = TabItem.photos
        self.photoPath = NavigationPath()
        self.photoPath.append(Photo.init(id: timelinePhotos[3].id))
    }
}


struct ContentView: View {
    @State private var loggedIn = false
    @StateObject var router = NavigationStore()
        
    var body: some View {
        if (loggedIn) {
            Tabs()
                .environmentObject(router)
                .onOpenURL { url in
                    router.resolveDeepLink()
                }
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
