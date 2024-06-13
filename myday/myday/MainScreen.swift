import SwiftUI

struct MainScreen: View {
    @State private var selectedTab = 0
    @State private var showBottomSheet = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                ZStack {
                    switch selectedTab {
                    case 0:
                        HomeView()
                    case 2:
                        ProfileView()
                    default:
                        HomeView()
                    }
                }
                Spacer()
                if !showBottomSheet {
                    CustomTabBar(selectedTab: $selectedTab, showBottomSheet: $showBottomSheet)
                }
            }
            
            if showBottomSheet {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
            }
            
            VStack {
                Spacer()
                BottomSheetView(showBottomSheet: $showBottomSheet)
                    .offset(y: showBottomSheet ? 0 : UIScreen.main.bounds.height)
                    .animation(.easeInOut, value: showBottomSheet)
            }
        }
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Profile Screen")
            .font(.largeTitle)
            .padding()
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}

