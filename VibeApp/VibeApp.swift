import SwiftUI

@main
struct VibeApp: App {
    @StateObject private var store = VibeStore.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
