import SwiftUI

struct Photos: View {
    @EnvironmentObject var router: Router

    var body: some View {
        NavigationStack(path: $router.photoPath) {
            VStack {
                List(timelinePhotos) { photo in
                    var _ = print("destination resolves \(photo.id)")
                    NavigationLink("Detail \(photo.id)", value: Destination.photo(photo: photo))
                }.navigationDestination(for: Destination.self) { destination in
                    switch destination {
                        case .album(let album): AlbumsDetail(album: album)
                        case .photo(let photo): PhotosDetail(photo: photo)
                    }
                }
            }
            .navigationTitle("Photos")
            .toolbar {
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                }
            }
        }.onChange(of: router.photoPath) { newValue in
            print("photos: path changed \(newValue)")
        }.onAppear() {
            print("photos init \(router.photoPath)")
        }
    }
}

/*
struct Photos_Previews: PreviewProvider {
    static var previews: some View {
        Photos()
    }
}
*/

struct PhotosDetail: View {
    @State private var isPresenting = false

    let photo: Photo
    var body: some View {
        VStack {
            Text("Photos Detail \(photo.id)")
            Button("ShowModal") {
                isPresenting.toggle()
            }
        }.fullScreenCover(isPresented: $isPresenting, content: PhotosModal.init)    }
}

struct PhotosModal: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Text("A full-screen modal view.")
                .font(.title)
            Text("Tap to Dismiss")
        }
        .onTapGesture {
            dismiss()
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .background(Color.blue)
        .ignoresSafeArea(edges: .all)
    }
}
