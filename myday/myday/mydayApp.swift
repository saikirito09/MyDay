import SwiftUI

@main
struct mydayApp: App {
    @StateObject private var navigationModel = NavigationModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigationModel)
        }
    }
}

