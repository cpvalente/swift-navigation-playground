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

enum RouterErrors: Error {
    case UnhandledPath(String)
}

final class Router: ObservableObject {
    @Published var selectedTab: TabItem = TabItem.me
    @Published var mePath = NavigationPath()
    @Published var photoPath = NavigationPath()
    @Published var albumPath = NavigationPath()
    
    init() {
        // router restores navigation when appropriate
        if (true) {
            self.selectedTab = TabItem.albums
        }
        
        if (true) {
            albumPath.append(albumList[0])
            albumPath.append(Photo.init(id: albumPhotos[3].id))
        }
    }
    
    func append(path: PathInStore, destination: any Hashable) throws {
        switch path {
            case PathInStore.me:
                self.mePath.append(destination)
            case PathInStore.photo:
                self.photoPath.append(destination)
            case PathInStore.album:
                self.albumPath.append(destination)
            case PathInStore.all:
                throw RouterErrors.UnhandledPath("Cannot append to all")
            }
    }
    
    func clear(path: PathInStore = PathInStore.all) {
        switch path {
            case PathInStore.me:
                self.mePath = NavigationPath()
            case PathInStore.photo:
                self.photoPath = NavigationPath()
            case PathInStore.album:
                self.albumPath = NavigationPath()
            case PathInStore.all:
                self.mePath = NavigationPath()
                self.photoPath = NavigationPath()
                self.albumPath = NavigationPath()
            }
    }
    
    func resolveDeepLink(url: URL) {
        print("resolving: \(url)")
        self.selectedTab = TabItem.photos
        self.photoPath = NavigationPath()
        self.photoPath.append(Photo.init(id: timelinePhotos[3].id))
    }
}


struct ContentView: View {
    @State private var loggedIn = false
    @StateObject var router = Router()
        
    var body: some View {
        if (loggedIn) {
            Tabs()
                .environmentObject(router)
                .onOpenURL { url in
                    router.resolveDeepLink(url: url)
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
