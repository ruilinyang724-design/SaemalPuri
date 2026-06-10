import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var settings: AppSettings

    var body: some View {
        NavigationStack {
            ZStack {
                ThemedBackground()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("设置")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .foregroundStyle(colorScheme == .dark ? Color.titleDark : Color.titleLight)

                        themeSection
                        accentSection
                        iconSection
                        dataSection
                        aboutSection
                    }
                    .padding(18)
                    .padding(.bottom, 26)
                }
            }
            .navigationBarHidden(true)
        }
    }

    var themeSection: some View {
        FrostedCard(cornerRadius: 22) {
            VStack(alignment: .leading, spacing: 14) {
                Text("主题模式")
                    .font(.headline)
                    .foregroundStyle(colorScheme == .dark ? Color.titleDark : Color.titleLight)

                ForEach(AppThemeMode.allCases) { mode in
                    Button {
                        settings.themeMode = mode
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: settings.themeMode == mode ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(settings.themeMode == mode ? settings.accent.color : .secondary)

                            VStack(alignment: .leading, spacing: 2) {
                                Text(mode.title)
                                    .font(.body.weight(.semibold))
                                Text(mode.subtitle)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(18)
        }
    }

    var accentSection: some View {
        FrostedCard(cornerRadius: 22) {
            VStack(alignment: .leading, spacing: 14) {
                Text("主题色")
                    .font(.headline)
                    .foregroundStyle(colorScheme == .dark ? Color.titleDark : Color.titleLight)

                HStack(spacing: 15) {
                    ForEach(AccentTheme.allCases) { accent in
                        Button {
                            settings.accent = accent
                        } label: {
                            Circle()
                                .fill(accent.color)
                                .frame(width: 34, height: 34)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white.opacity(0.85), lineWidth: settings.accent == accent ? 3 : 0)
                                )
                                .overlay {
                                    if settings.accent == accent {
                                        Image(systemName: "checkmark")
                                            .font(.caption.bold())
                                            .foregroundStyle(.white)
                                    }
                                }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(18)
        }
    }

    var iconSection: some View {
        FrostedCard(cornerRadius: 22) {
            HStack(spacing: 16) {
                Image(colorScheme == .dark ? "HeroDark" : "HeroLight")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 72, height: 72)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

                VStack(alignment: .leading, spacing: 6) {
                    Text("앱 아이콘")
                        .font(.headline)
                    Text("图标和夜间界面已按你的紫色视觉风格适配。")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(18)
        }
    }

    var dataSection: some View {
        FrostedCard(cornerRadius: 22) {
            VStack(spacing: 0) {
                settingRow(icon: "square.and.arrow.down", title: "词库导入", subtitle: "v1.3 开放")
                Divider().opacity(0.4)
                settingRow(icon: "square.and.arrow.up", title: "词库导出", subtitle: "v1.3 开放")
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 4)
        }
    }

    var aboutSection: some View {
        FrostedCard(cornerRadius: 22) {
            VStack(alignment: .leading, spacing: 8) {
                Text("새말풀이")
                    .font(.headline)
                Text("韩语固有词词典工具 · v1.2 UI 完整版")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(18)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    func settingRow(icon: String, title: String, subtitle: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(settings.accent.color)
                .frame(width: 30)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body.weight(.semibold))
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .font(.caption.bold())
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 14)
    }
}
