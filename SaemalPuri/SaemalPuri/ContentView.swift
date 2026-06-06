import SwiftUI

struct ContentView: View {
    @State private var searchText = ""

    let entries: [WordEntry] = WordStore.loadWords()

    var filteredEntries: [WordEntry] {
        let trimmedText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmedText.isEmpty {
            return entries
        }

        return entries.filter { entry in
            entry.word.localizedCaseInsensitiveContains(trimmedText) ||
            entry.sourceWord.localizedCaseInsensitiveContains(trimmedText) ||
            entry.category.localizedCaseInsensitiveContains(trimmedText) ||
            entry.formation.localizedCaseInsensitiveContains(trimmedText) ||
            entry.meaning.localizedCaseInsensitiveContains(trimmedText) ||
            entry.note.localizedCaseInsensitiveContains(trimmedText)
        }
    }

    var groupedEntries: [(category: String, entries: [WordEntry])] {
        let grouped = Dictionary(grouping: filteredEntries) { entry in
            entry.category
        }

        return grouped
            .map { category, entries in
                (
                    category: category,
                    entries: entries.sorted { $0.id < $1.id }
                )
            }
            .sorted { first, second in
                categoryOrder(first.category) < categoryOrder(second.category)
            }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(groupedEntries, id: \.category) { group in
                    Section {
                        ForEach(group.entries) { entry in
                            NavigationLink {
                                WordDetailView(entry: entry)
                            } label: {
                                WordRowView(entry: entry)
                            }
                        }
                    } header: {
                        Text(group.category)
                            .font(.headline)
                    }
                }
            }
            .navigationTitle("새말풀이")
            .searchable(text: $searchText, prompt: "搜索词条、来源词、分类")
            .overlay {
                if filteredEntries.isEmpty {
                    ContentUnavailableView(
                        "没有找到词条",
                        systemImage: "magnifyingglass",
                        description: Text("试试搜索韩语词、英文词、中文词或分类。")
                    )
                }
            }
        }
    }

    func categoryOrder(_ category: String) -> Int {
        switch category {
        case "网络科技":
            return 1
        case "经济财政":
            return 2
        case "医学":
            return 3
        case "法制政体":
            return 4
        case "社会称谓":
            return 5
        default:
            return 999
        }
    }
}

struct WordRowView: View {
    let entry: WordEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(entry.word)
                .font(.headline)

            Text(entry.sourceWord)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(entry.formation)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ContentView()
}
