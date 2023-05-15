import SwiftUI

struct Albums: View {
    @EnvironmentObject var router: NavigationStore

    let albums = ["aa", "bb", "cc", "dd"]
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                List(albums, id: \.self) { album in
                    NavigationLink("Detail \(album)", value: album)
                }.navigationDestination(for: String.self) { album in
                    AlbumsDetail(albumId: album)
                    
                }
            }.navigationTitle("Albums")
                .toolbar {
                    Button(action: {}) {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                    }
                }
        }
    }
}

/*
struct Albums_Previews: PreviewProvider {
    static var previews: some View {
        Albums()
    }
}
 */

struct AlbumsDetail: View {
    let albumId: String
    var body: some View {
        Text("Album Detail \(albumId)")
            .toolbar {
                Button(action: {}) {
                    Image(systemName: "square.and.arrow.up.circle")
                }
            }
    }
}
