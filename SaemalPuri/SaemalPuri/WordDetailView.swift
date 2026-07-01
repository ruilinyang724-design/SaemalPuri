import SwiftUI

struct WordDetailView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    let entry: WordEntry

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ThemedBackground()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 18) {
                        heroCard
                        detailCard(title: "构词", content: entry.formation, icon: "sparkles")
                        detailCard(title: "释义", content: entry.meaning, icon: "text.book.closed.fill")
                        detailCard(title: "备注", content: entry.note, icon: "note.text")
                        examplesCard
                        wordTagsCard(title: "近义词", words: entry.synonyms ?? [], icon: "arrow.left.arrow.right")
                        wordTagsCard(title: "反义词", words: entry.antonyms ?? [], icon: "arrow.up.arrow.down")
                        actionButtons
                    }
                    .padding(18)
                    .padding(.bottom, 26)
                    .frame(width: proxy.size.width, alignment: .leading)
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .frame(width: proxy.size.width, height: proxy.size.height)
            .clipped()
        }
        .navigationTitle("词条详情")
        .navigationBarTitleDisplayMode(.inline)
    }

    var heroCard: some View {
        FrostedCard(cornerRadius: 24) {
            ZStack(alignment: .topTrailing) {
                Image(colorScheme == .dark ? "HeroDark" : "HeroLight")
                    .resizable()
                    .scaledToFill()
                    .opacity(colorScheme == .dark ? 0.22 : 0.14)
                    .frame(height: 170)
                    .clipped()

                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(entry.word)
                                .font(.system(size: 38, weight: .bold, design: .rounded))
                                .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)
                                .textSelection(.enabled)

                            Text(entry.sourceWord)
                                .font(.title3.weight(.medium))
                                .foregroundStyle(colorScheme == .dark ? Color.secondaryDark : .secondary)
                                .textSelection(.enabled)
                        }

                        Spacer()
                        StarButton(entry: entry)
                    }

                    HStack(spacing: 8) {
                        tag(entry.category)
                        tag(entry.partOfSpeechText)
                    }
                }
                .padding(20)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    func detailCard(title: String, content: String, icon: String) -> some View {
        FrostedCard(cornerRadius: 20) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 8) {
                    Image(systemName: icon)
                        .foregroundStyle(settings.accent.color)
                    Text(title)
                        .font(.headline)
                        .foregroundStyle(colorScheme == .dark ? Color.titleDark : Color.titleLight)
                }

                Text(content)
                    .font(.body)
                    .lineSpacing(4)
                    .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)
                    .textSelection(.enabled)
            }
            .padding(18)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    var examplesCard: some View {
        let examples = entry.examples ?? []
        return Group {
            if !examples.isEmpty {
                FrostedCard(cornerRadius: 20) {
                    VStack(alignment: .leading, spacing: 14) {
                        HStack(spacing: 8) {
                            Image(systemName: "quote.bubble.fill")
                                .foregroundStyle(settings.accent.color)
                            Text("例句")
                                .font(.headline)
                                .foregroundStyle(colorScheme == .dark ? Color.titleDark : Color.titleLight)
                        }

                        ForEach(examples) { example in
                            VStack(alignment: .leading, spacing: 6) {
                                Text("+ " + example.korean)
                                    .font(.body.weight(.semibold))
                                    .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)
                                Text(example.chinese)
                                    .font(.subheadline)
                                    .foregroundStyle(colorScheme == .dark ? Color.secondaryDark : .secondary)
                            }
                        }
                    }
                    .padding(18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }

    func wordTagsCard(title: String, words: [String], icon: String) -> some View {
        Group {
            if !words.isEmpty {
                FrostedCard(cornerRadius: 20) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 8) {
                            Image(systemName: icon)
                                .foregroundStyle(settings.accent.color)
                            Text(title)
                                .font(.headline)
                                .foregroundStyle(colorScheme == .dark ? Color.titleDark : Color.titleLight)
                        }

                        FlowLayout(items: words) { word in
                            Text(word)
                                .font(.subheadline.weight(.semibold))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .foregroundStyle(settings.accent.color)
                                .background(settings.accent.color.opacity(0.14))
                                .clipShape(Capsule())
                        }
                    }
                    .padding(18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }

    var actionButtons: some View {
        HStack(spacing: 14) {
            ShareLink(item: "\(entry.word)\n\(entry.sourceWord)\n\(entry.meaning)") {
                Label("分享", systemImage: "square.and.arrow.up")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(ThemedButtonStyle())

            Button {
                UIPasteboard.general.string = "\(entry.word)\n\(entry.sourceWord)\n\(entry.formation)\n\(entry.meaning)"
            } label: {
                Label("复制", systemImage: "doc.on.doc")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(ThemedButtonStyle())
        }
    }

    func tag(_ text: String) -> some View {
        Text(text)
            .font(.caption.weight(.bold))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .foregroundStyle(settings.accent.color)
            .background(settings.accent.color.opacity(0.15))
            .clipShape(Capsule())
    }
}

struct ThemedButtonStyle: ButtonStyle {
    @EnvironmentObject private var settings: AppSettings

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding(.vertical, 14)
            .foregroundStyle(Color.white)
            .background(settings.accent.color.opacity(configuration.isPressed ? 0.70 : 0.95))
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

struct FlowLayout<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    let items: Data
    let content: (Data.Element) -> Content

    init(items: Data, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.items = items
        self.content = content
    }

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 82), spacing: 8)], alignment: .leading, spacing: 8) {
            ForEach(Array(items), id: \.self) { item in
                content(item)
            }
        }
    }
}
