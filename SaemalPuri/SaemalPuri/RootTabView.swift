import SwiftUI

struct RootTabView: View {
    let entries: [WordEntry] = WordStore.loadWords()

    var body: some View {
        TabView {
            ContentView(entries: entries)
                .tabItem { Label("首页", systemImage: "house.fill") }

            CategoryView(entries: entries)
                .tabItem { Label("分类", systemImage: "square.grid.2x2.fill") }

            FavoritesView(entries: entries)
                .tabItem { Label("收藏", systemImage: "star.fill") }

            SettingsView()
                .tabItem { Label("设置", systemImage: "gearshape.fill") }
        }
    }
}
