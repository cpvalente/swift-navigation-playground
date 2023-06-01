import SwiftUI


struct Albums: View {
    @EnvironmentObject var router: NavigationStore
    
    var body: some View {
        NavigationStack(path: $router.albumPath) {
            VStack {
                List(albumList) { album in
                    NavigationLink("Detail \(album.name)", value: album)
                }.navigationDestination(for: Album.self) { album in
                    AlbumsDetail(album: album)
                }
            }
            .navigationTitle("Albums")
            .toolbar {
                Button(action: {}) {
                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                }
            }
        }.onChange(of: router.albumPath) { newValue in
            print("albums: path changed \(newValue)")
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

let albumPhotos: [Photo] = [
    Photo(id: "album photo 1"),
    Photo(id: "album photo 2"),
    Photo(id: "album photo 3"),
    Photo(id: "album photo 4"),
    Photo(id: "album photo 5"),
    Photo(id: "album photo 6"),
    Photo(id: "album photo 7"),
    Photo(id: "album photo 8"),
    Photo(id: "album photo 9"),
]

struct AlbumsDetail: View {
    let album: Album
       
    var body: some View {
        VStack {
            Text("Album list \(album.name)")
            List(albumPhotos) { photo in
                var _ = print("destination resolves \(photo)")
                NavigationLink("\(album.id) \(photo.id)", value: photo)
            }
            .navigationDestination(for: Photo.self) { photo in
                PhotosDetail(photo: photo)
            }
        }

    }
}
