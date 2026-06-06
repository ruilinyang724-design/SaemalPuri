import Foundation

struct WordEntry: Identifiable, Codable {
    let id: Int
    let word: String
    let sourceWord: String
    let category: String
    let formation: String
    let meaning: String
    let note: String
}
