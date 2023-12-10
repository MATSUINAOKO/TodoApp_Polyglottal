import SwiftUI

struct Top: View {
    @State private var selectedCategory: String?
    
    var body: some View {
        VStack {
            UserView(image: Image("profile"), userName: " Matsumoto Naoko")
            NavigationView {
                List {
                    NavigationLink(destination: CheckItem()
                        .environmentObject(UserData())) {
                            Image(systemName: "macpro.gen3.fill")
                                .imageScale(.large)
                            Text("Work")
                            
                            
                        }
                    
                    NavigationLink(destination: CheckItem_Home()
                        .environmentObject(UserData())) {
                            Image(systemName: "house.fill")
                                .imageScale(.large)
                            Text("Home")
                            
                        }
                }
            }
        }
        
    }
}

struct Top_Previews: PreviewProvider {
    static var previews: some View {
        Top()
    }
}
