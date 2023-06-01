import SwiftUI

enum TabItem: String, Hashable {
    case me = "me"
    case albums = "albums"
    case photos = "photos"
}

struct Tabs: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        TabView(selection: $router.selectedTab) {
            
            Me()
                .tabItem {
                    Label("Me", systemImage: "return.left")
                }
                .tag(TabItem.me)

            Albums()
                .tabItem {
                    Label("Albums", systemImage: "return.right")
                }
                .tag(TabItem.albums)

            Photos()
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
