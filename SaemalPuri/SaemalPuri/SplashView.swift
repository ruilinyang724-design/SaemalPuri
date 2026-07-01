import SwiftUI

struct SplashView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings
    @State private var iconScale: CGFloat = 0.86
    @State private var iconOpacity: Double = 0.0
    @State private var titleOffset: CGFloat = 12
    @State private var titleOpacity: Double = 0.0

    var body: some View {
        ZStack {
            ThemedBackground()

            VStack(spacing: 24) {
                Image(colorScheme == .dark ? "HeroDark" : "HeroLight")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 132, height: 132)
                    .clipShape(RoundedRectangle(cornerRadius: 34, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 34, style: .continuous)
                            .stroke(settings.accent.color.opacity(0.55), lineWidth: 1.2)
                    )
                    .shadow(color: settings.accent.color.opacity(colorScheme == .dark ? 0.55 : 0.22), radius: 30, x: 0, y: 14)
                    .scaleEffect(iconScale)
                    .opacity(iconOpacity)

                VStack(spacing: 8) {
                    Text("새말풀이")
                        .font(.system(size: 38, weight: .bold, design: .rounded))
                        .foregroundStyle(colorScheme == .dark ? Color.titleDark : Color.titleLight)

                    Text("한국어 · 우리말 사전")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(colorScheme == .dark ? Color.secondaryDark : .secondary)
                }
                .offset(y: titleOffset)
                .opacity(titleOpacity)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.58, dampingFraction: 0.78)) {
                iconScale = 1.0
                iconOpacity = 1.0
            }
            withAnimation(.easeOut(duration: 0.55).delay(0.18)) {
                titleOffset = 0
                titleOpacity = 1.0
            }
        }
    }
}
