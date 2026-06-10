import SwiftUI

@main
struct SaemalPuriApp: App {
    @StateObject private var settings = AppSettings()
    @StateObject private var favorites = FavoriteStore()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(settings)
                .environmentObject(favorites)
                .preferredColorScheme(settings.themeMode.colorScheme)
                .tint(settings.accent.color)
        }
    }
}
