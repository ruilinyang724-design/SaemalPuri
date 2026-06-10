import SwiftUI

struct ThemedBackground: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings

    var body: some View {
        ZStack {
            LinearGradient(
                colors: colorScheme == .dark
                ? [.appBgDark, Color(red: 0.06, green: 0.02, blue: 0.09), Color.black]
                : [.appBgLight, Color(red: 1.0, green: 0.93, blue: 0.98), Color(red: 0.96, green: 0.93, blue: 1.0)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Image(colorScheme == .dark ? "HeroDark" : "HeroLight")
                .resizable()
                .scaledToFill()
                .opacity(colorScheme == .dark ? 0.13 : 0.10)
                .blur(radius: 0.5)
                .ignoresSafeArea()

            RadialGradient(
                colors: [settings.accent.color.opacity(colorScheme == .dark ? 0.22 : 0.15), .clear],
                center: .topTrailing,
                startRadius: 30,
                endRadius: 360
            )
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}

struct FrostedCard<Content: View>: View {
    @Environment(\.colorScheme) private var colorScheme
    let cornerRadius: CGFloat
    let content: Content

    init(cornerRadius: CGFloat = 20, @ViewBuilder content: () -> Content) {
        self.cornerRadius = cornerRadius
        self.content = content()
    }

    var body: some View {
        content
            .background(colorScheme == .dark ? Color.cardDark : Color.cardLight)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(colorScheme == .dark ? Color.borderDark : Color.borderLight.opacity(0.55), lineWidth: 1)
            )
            .shadow(color: .black.opacity(colorScheme == .dark ? 0.22 : 0.05), radius: 14, x: 0, y: 8)
    }
}

struct CategoryChip: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    let title: String
    let isSelected: Bool

    var body: some View {
        Text(title)
            .font(.subheadline.weight(.semibold))
            .padding(.horizontal, 15)
            .padding(.vertical, 9)
            .foregroundStyle(isSelected ? Color.white : (colorScheme == .dark ? Color.secondaryDark : Color.titleLight))
            .background(isSelected ? settings.accent.color : (colorScheme == .dark ? Color.cardDark : Color.white.opacity(0.78)))
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(colorScheme == .dark ? Color.borderDark : Color.borderLight.opacity(0.45), lineWidth: isSelected ? 0 : 1)
            )
    }
}

struct StarButton: View {
    @EnvironmentObject private var favorites: FavoriteStore
    @EnvironmentObject private var settings: AppSettings
    let entry: WordEntry

    var body: some View {
        Button {
            favorites.toggle(entry)
        } label: {
            Image(systemName: favorites.isFavorite(entry) ? "star.fill" : "star")
                .font(.title3)
                .symbolEffect(.bounce, value: favorites.isFavorite(entry))
                .foregroundStyle(favorites.isFavorite(entry) ? settings.accent.color : .secondary)
                .frame(width: 36, height: 36)
        }
        .buttonStyle(.plain)
    }
}

struct WordRowCard: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    let entry: WordEntry

    var body: some View {
        FrostedCard(cornerRadius: 18) {
            HStack(alignment: .center, spacing: 12) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 6) {
                        Text(entry.word)
                            .font(.title3.bold())
                            .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)

                        Text(entry.partOfSpeechText)
                            .font(.caption2.weight(.bold))
                            .padding(.horizontal, 7)
                            .padding(.vertical, 3)
                            .foregroundStyle(settings.accent.color)
                            .background(settings.accent.color.opacity(0.14))
                            .clipShape(Capsule())
                    }

                    Text(entry.sourceWord)
                        .font(.body)
                        .foregroundStyle(colorScheme == .dark ? Color.secondaryDark : .secondary)
                        .lineLimit(1)

                    Text(entry.meaning)
                        .font(.caption)
                        .foregroundStyle(colorScheme == .dark ? Color.secondaryDark : .secondary)
                        .lineLimit(1)
                }

                Spacer()
                StarButton(entry: entry)
            }
            .padding(16)
        }
    }
}
