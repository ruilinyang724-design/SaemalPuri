import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    let entries: [WordEntry]

    @State private var searchText = ""
    @State private var selectedCategory = "全部"

    var categories: [String] {
        ["全部"] + Array(Set(entries.map(\.category))).sorted { categoryOrder($0) < categoryOrder($1) }
    }

    var filteredEntries: [WordEntry] {
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        return entries.filter { entry in
            let categoryMatches = selectedCategory == "全部" || entry.category == selectedCategory
            let textMatches = trimmed.isEmpty ||
                entry.word.localizedCaseInsensitiveContains(trimmed) ||
                entry.sourceWord.localizedCaseInsensitiveContains(trimmed) ||
                entry.category.localizedCaseInsensitiveContains(trimmed) ||
                entry.formation.localizedCaseInsensitiveContains(trimmed) ||
                entry.meaning.localizedCaseInsensitiveContains(trimmed) ||
                entry.note.localizedCaseInsensitiveContains(trimmed)
            return categoryMatches && textMatches
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ThemedBackground()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        header
                        searchBar
                        categoryScroller
                        wordList
                    }
                    .padding(.horizontal, 18)
                    .padding(.top, 18)
                    .padding(.bottom, 28)
                }
            }
            .navigationBarHidden(true)
        }
    }

    var header: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 7) {
                Text("새말풀이")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundStyle(colorScheme == .dark ? Color.titleDark : Color.titleLight)

                Text("한국어 · 우리말 사전")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(colorScheme == .dark ? Color.secondaryDark : .secondary)
            }

            Spacer()

            Image(colorScheme == .dark ? "HeroDark" : "HeroLight")
                .resizable()
                .scaledToFill()
                .frame(width: 62, height: 62)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(settings.accent.color.opacity(0.45), lineWidth: 1)
                )
        }
    }

    var searchBar: some View {
        FrostedCard(cornerRadius: 17) {
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
                    .foregroundStyle(settings.accent.color)

                TextField("搜索词条、来源词、分类", text: $searchText)
                    .textInputAutocapitalization(.never)
                    .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 13)
        }
    }

    var categoryScroller: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(categories, id: \.self) { category in
                    Button {
                        withAnimation(.spring(response: 0.25, dampingFraction: 0.85)) {
                            selectedCategory = category
                        }
                    } label: {
                        CategoryChip(title: category, isSelected: selectedCategory == category)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    var wordList: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(selectedCategory == "全部" ? "全部词条" : selectedCategory)
                    .font(.title2.bold())
                    .foregroundStyle(colorScheme == .dark ? Color.titleDark : Color.titleLight)

                Spacer()

                Text("\(filteredEntries.count)")
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(settings.accent.color)
            }

            if filteredEntries.isEmpty {
                FrostedCard {
                    ContentUnavailableView("没有找到词条", systemImage: "magnifyingglass", description: Text("试试搜索韩语词、英文词、中文词或分类。"))
                        .padding()
                }
            } else {
                ForEach(filteredEntries) { entry in
                    NavigationLink {
                        WordDetailView(entry: entry)
                    } label: {
                        WordRowCard(entry: entry)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    func categoryOrder(_ category: String) -> Int {
        switch category {
        case "全部": return 0
        case "网络科技": return 1
        case "经济财政": return 2
        case "医学": return 3
        case "法制政体": return 4
        case "社会称谓": return 5
        default: return 999
        }
    }
}
