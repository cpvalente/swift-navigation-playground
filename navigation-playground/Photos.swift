import SwiftUI

struct Photos: View {
    @StateObject var router = NavigationStore()
           
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                List(timelinePhotos) { photo in
                    var _ = print("destination resolves \(photo.id)")
                    NavigationLink("Detail \(photo.id)", value: photo)
                }.navigationDestination(for: Photo.self) { photo in
                    PhotosDetail(photo: photo)
                }
            }
            .navigationTitle("Photos")
            .toolbar {
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                }
            }
        }.onChange(of: router.path) { newValue in
            print("photos: path changed \(newValue)")
        }.onAppear() {
            print("photos init \(router.path)")
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
