import Foundation

final class WordStore {
    static func loadWords() -> [WordEntry] {
        guard let url = Bundle.main.url(forResource: "words", withExtension: "json") else {
            print("找不到 words.json")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let entries = try JSONDecoder().decode([WordEntry].self, from: data)
            return entries
        } catch {
            print("读取 words.json 失败：\(error)")
            return []
        }
    }
}
