import SwiftUI

struct CategoryView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    let entries: [WordEntry]

    var grouped: [(String, [WordEntry])] {
        Dictionary(grouping: entries, by: \.category)
            .map { ($0.key, $0.value.sorted { $0.id < $1.id }) }
            .sorted { categoryOrder($0.0) < categoryOrder($1.0) }
    }

    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                ZStack {
                    ThemedBackground()

                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 18) {
                            Text("分类")
                                .font(.system(size: 34, weight: .bold, design: .rounded))
                                .foregroundStyle(colorScheme == .dark ? Color.titleDark : Color.titleLight)

                            ForEach(grouped, id: \.0) { category, words in
                                NavigationLink {
                                    CategoryWordListView(category: category, entries: words)
                                } label: {
                                    FrostedCard(cornerRadius: 18) {
                                        HStack(spacing: 14) {
                                            Image(systemName: icon(for: category))
                                                .font(.title2)
                                                .foregroundStyle(settings.accent.color)
                                                .frame(width: 42, height: 42)
                                                .background(settings.accent.color.opacity(0.14))
                                                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(category)
                                                    .font(.headline)
                                                    .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)
                                                Text("\(words.count) 个词条")
                                                    .font(.subheadline)
                                                    .foregroundStyle(colorScheme == .dark ? Color.secondaryDark : .secondary)
                                            }

                                            Spacer()

                                            Text("\(words.count)")
                                                .font(.headline)
                                                .foregroundStyle(settings.accent.color)
                                        }
                                        .padding(16)
                                    }
                                }
                                .buttonStyle(.plain)
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

    func icon(for category: String) -> String {
        switch category {
        case "网络科技": return "network"
        case "经济财政": return "banknote.fill"
        case "医学": return "cross.case.fill"
        case "法制政体": return "building.columns.fill"
        case "社会称谓": return "person.2.fill"
        default: return "square.grid.2x2.fill"
        }
    }

    func categoryOrder(_ category: String) -> Int {
        switch category {
        case "网络科技": return 1
        case "经济财政": return 2
        case "医学": return 3
        case "法制政体": return 4
        case "社会称谓": return 5
        default: return 999
        }
    }
}

struct CategoryWordListView: View {
    @Environment(\.colorScheme) private var colorScheme
    let category: String
    let entries: [WordEntry]

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ThemedBackground()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 14) {
                        Text(category)
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundStyle(colorScheme == .dark ? Color.titleDark : Color.titleLight)

                        ForEach(entries) { entry in
                            NavigationLink {
                                WordDetailView(entry: entry)
                            } label: {
                                WordRowCard(entry: entry)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(18)
                    .frame(width: proxy.size.width, alignment: .leading)
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .clipped()
        }
        .navigationTitle(category)
        .navigationBarTitleDisplayMode(.inline)
    }
}
