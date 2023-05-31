import SwiftUI

enum TabItem: String, Hashable {
    case me = "me"
    case albums = "albums"
    case photos = "photos"
}

struct Tabs: View {
    @Binding var initialTab: TabItem
    @Binding var initialPath: [any Hashable]

    var body: some View {
        TabView(selection: $initialTab) {
            
            // [ Settings, Modals(modal1) ]

            Me(initialPath: $initialPath)
                .tabItem {
                    Label("Me", systemImage: "return.left")
                }
                .tag(TabItem.me)

            Albums(initialPath: $initialPath)
                .tabItem {
                    Label("Albums", systemImage: "return.right")
                }
                .tag(TabItem.albums)

            Photos(initialPath: $initialPath)
                .tabItem {
                    Label("Photos", systemImage: "return.right")
                }
                .tag(TabItem.photos)
        }
    }
}

/*
struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs()
    }
}
 */
