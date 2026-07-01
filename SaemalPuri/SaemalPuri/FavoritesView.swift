import SwiftUI

struct FavoritesView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var favorites: FavoriteStore
    let entries: [WordEntry]

    var favoriteEntries: [WordEntry] {
        entries.filter { favorites.isFavorite($0) }
    }

    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                ZStack {
                    ThemedBackground()

                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("收藏")
                                    .font(.system(size: 34, weight: .bold, design: .rounded))
                                    .foregroundStyle(colorScheme == .dark ? Color.titleDark : Color.titleLight)
                                Spacer()
                                Text("\(favoriteEntries.count)")
                                    .font(.headline)
                                    .foregroundStyle(.secondary)
                            }

                            if favoriteEntries.isEmpty {
                                FrostedCard(cornerRadius: 22) {
                                    ContentUnavailableView("还没有收藏", systemImage: "star", description: Text("在词条右侧点星标，就会出现在这里。"))
                                        .padding(22)
                                }
                            } else {
                                ForEach(favoriteEntries) { entry in
                                    NavigationLink {
                                        WordDetailView(entry: entry)
                                    } label: {
                                        WordRowCard(entry: entry)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .padding(18)
                        .padding(.bottom, 24)
                        .frame(width: proxy.size.width, alignment: .leading)
                    }
                    .frame(width: proxy.size.width, height: proxy.size.height)
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
                .clipped()
            }
            .navigationBarHidden(true)
        }
    }
}
