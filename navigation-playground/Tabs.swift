import SwiftUI

// tab style
// https://ondrej-kvasnovsky.medium.com/how-display-a-notification-count-badge-in-swiftui-f4fd243f557

enum TabItems: String, Hashable {
    case me = "me"
    case albums = "albums"
    case photos = "photos"
}


struct Tabs: View {
    @Binding var resolver: TabItems
    @State var path: [String]
    
    var body: some View {
            TabView(selection: $resolver) {
                Me(path: path)
                    .tabItem {
                        Label("Me", systemImage: "return.left")
                    }.tag(TabItems.me)
                Albums(path: path)
                    .tabItem {
                        Label("Albums", systemImage: "return.right")
                    }.tag(TabItems.albums)
                Photos(path: path)
                    .tabItem {
                        Label("Photos", systemImage: "return.right")
                    }
                    .tag(TabItems.photos)
                    .badge(3)
            }.onChange(of: resolver, perform: {
                _ in
                print("using resolver \(resolver)")
            })
    }
}

/*
struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs()
    }
}
 */

struct NotificationCountView : View {
  
  @Binding var value: Int
  @State var foreground: Color = .white
  @State var background: Color = .red
  
  private let size = 16.0
  private let x = 20.0
  private let y = 0.0
  
  var body: some View {
    ZStack {
      Capsule()
        .fill(background)
        .frame(width: size * widthMultplier(), height: size, alignment: .topTrailing)
        .position(x: x, y: y)
      
      if hasTwoOrLessDigits() {
        Text("\(value)")
          .foregroundColor(foreground)
          .font(Font.caption)
          .position(x: x, y: y)
      } else {
        Text("99+")
          .foregroundColor(foreground)
          .font(Font.caption)
          .frame(width: size * widthMultplier(), height: size, alignment: .center)
          .position(x: x, y: y)
      }
    }
    .opacity(value == 0 ? 0 : 1)
  }
  
  // showing more than 99 might take too much space, rather display something like 99+
  func hasTwoOrLessDigits() -> Bool {
    return value < 100
  }
  
  func widthMultplier() -> Double {
    if value < 10 {
      // one digit
      return 1.0
    } else if value < 100 {
      // two digits
      return 1.5
    } else {
      // too many digits, showing 99+
      return 2.0
    }
  }
}
