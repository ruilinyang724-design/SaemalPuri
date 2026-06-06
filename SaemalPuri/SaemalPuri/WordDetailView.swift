import SwiftUI

struct WordDetailView: View {
    let entry: WordEntry

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                headerView

                VStack(spacing: 16) {
                    DetailCard(title: "构词", content: entry.formation)
                    DetailCard(title: "释义", content: entry.meaning)
                    DetailCard(title: "备注", content: entry.note)
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(entry.word)
        .navigationBarTitleDisplayMode(.inline)
    }

    var headerView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(entry.word)
                .font(.system(size: 40, weight: .bold))
                .textSelection(.enabled)

            Text(entry.sourceWord)
                .font(.title3)
                .foregroundStyle(.secondary)
                .textSelection(.enabled)

            Text(entry.category)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color(.secondarySystemGroupedBackground))
                .clipShape(Capsule())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct DetailCard: View {
    let title: String
    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)

            Text(content)
                .font(.body)
                .textSelection(.enabled)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
