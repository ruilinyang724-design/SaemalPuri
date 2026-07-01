import SwiftUI

@main
struct SaemalPuriApp: App {
    @StateObject private var settings = AppSettings()
    @StateObject private var favorites = FavoriteStore()
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                RootTabView()
                    .environmentObject(settings)
                    .environmentObject(favorites)
                    .preferredColorScheme(settings.themeMode.colorScheme)
                    .tint(settings.accent.color)

                if showSplash {
                    SplashView()
                        .environmentObject(settings)
                        .transition(.opacity)
                        .zIndex(10)
                }
            }
            .task {
                try? await Task.sleep(nanoseconds: 1_150_000_000)
                withAnimation(.easeInOut(duration: 0.36)) {
                    showSplash = false
                }
            }
        }
    }
}
