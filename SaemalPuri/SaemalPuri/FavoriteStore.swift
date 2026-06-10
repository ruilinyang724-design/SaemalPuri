import Foundation

final class FavoriteStore: ObservableObject {
    @Published private(set) var favoriteIDs: Set<Int>

    init() {
        let rawValue = UserDefaults.standard.string(forKey: "favoriteWordIDs") ?? ""
        self.favoriteIDs = Set(rawValue.split(separator: ",").compactMap { Int($0) })
    }

    func isFavorite(_ entry: WordEntry) -> Bool {
        favoriteIDs.contains(entry.id)
    }

    func toggle(_ entry: WordEntry) {
        if favoriteIDs.contains(entry.id) {
            favoriteIDs.remove(entry.id)
        } else {
            favoriteIDs.insert(entry.id)
        }
        save()
    }

    private func save() {
        let rawValue = favoriteIDs.sorted().map(String.init).joined(separator: ",")
        UserDefaults.standard.set(rawValue, forKey: "favoriteWordIDs")
    }
}
