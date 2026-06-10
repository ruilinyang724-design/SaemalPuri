import Foundation

struct WordEntry: Identifiable, Codable, Hashable {
    let id: Int
    let word: String
    let sourceWord: String
    let category: String
    let formation: String
    let meaning: String
    let note: String
    let partOfSpeech: String?
    let examples: [ExampleSentence]?
    let synonyms: [String]?
    let antonyms: [String]?

    var partOfSpeechText: String {
        partOfSpeech ?? category
    }
}

struct ExampleSentence: Identifiable, Codable, Hashable {
    let korean: String
    let chinese: String

    var id: String {
        korean + chinese
    }
}
