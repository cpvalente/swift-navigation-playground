/* see https://github.com/tunds/SwiftUI-Navigation-Multiplatform-Example/blob/main/Project/Introduction%20to%20NavigationStack/Route.swift
*/

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

enum Destination {
    case photo(photo: Photo, showModal: Bool = false)
    case album(album: Album)
}

extension Destination: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    static func == (lhs: Destination, rhs: Destination) -> Bool {
        switch (lhs, rhs) {
        case(.photo(let lhs, _), .photo(let rhs, _)):
            return lhs.id == rhs.id
        case(.album(let lhs), .album(let rhs)):
            return lhs.id == rhs.id
        default:
            return false
        }
    }
}

// dictionary of known destinations
let destinations: [String: (TabItem, [Destination])] = [
    "capture-app://t": (TabItem.albums, [
        Destination.album(album: albumList[0]),
        Destination.photo(photo: albumPhotos[0], showModal: true)
    ])
]


enum RouterErrors: Error {
    case UnhandledPath(String)
}

final class Router: ObservableObject {
    @Published var selectedTab: TabItem = TabItem.me
    @Published var mePath: [Destination]
    @Published var photoPath: [Destination]
    @Published var albumPath: [Destination]
    
    init() {
        self.mePath = []
        self.photoPath = []
        self.albumPath = []
        
        // router restores navigation when appropriate
        if (true) {
            self.selectedTab = TabItem.albums
        }
        
        if (true) {
            self.albumPath.append(Destination.album(album: albumList[1]))
            self.albumPath.append(Destination.photo(photo: albumPhotos[3]))
        }
    }
    
    func append(tabRouter: TabItem, destination: Destination) {
        switch tabRouter {
        case TabItem.me:
            self.mePath.append(destination)
        case TabItem.photos:
            self.photoPath.append(destination)
        case TabItem.albums:
            self.albumPath.append(destination)
        }
    }
    
    func replace(tabRouter: TabItem, destination: [Destination]) {
        print("replace \(tabRouter) \(destination)")
        switch tabRouter {
            case TabItem.me:
                self.mePath = destination
            case TabItem.photos:
                self.photoPath = destination
            case TabItem.albums:
                self.albumPath = destination
            }
    }
    
    func clear(tabRouter: TabItem) {
        switch tabRouter {
            case TabItem.me:
                self.mePath = []
            case TabItem.photos:
                self.photoPath = []
            case TabItem.albums:
                self.albumPath = []
            }
    }
    
    func resolveDeepLink(url: URL) {
        print("resolving: \(url)")
        
        let parsedURL = url.absoluteString
        if let (tab, path) = destinations[parsedURL] {
            print("resolved deep link \(tab) \(path)")
            self.selectedTab = tab
            self.replace(tabRouter: selectedTab, destination: path)
        }
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
