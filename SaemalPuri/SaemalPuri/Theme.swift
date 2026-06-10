import SwiftUI

enum AppThemeMode: String, CaseIterable, Identifiable {
    case system
    case light
    case dark

    var id: String { rawValue }

    var title: String {
        switch self {
        case .system: return "跟随系统"
        case .light: return "浅色模式"
        case .dark: return "夜间模式"
        }
    }

    var subtitle: String {
        switch self {
        case .system: return "自动适配 iOS 外观"
        case .light: return "明亮粉紫词典风格"
        case .dark: return "紫黑夜间主题"
        }
    }

    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}

enum AccentTheme: String, CaseIterable, Identifiable {
    case purple
    case pink
    case rose
    case orange
    case green
    case blue

    var id: String { rawValue }

    var color: Color {
        switch self {
        case .purple: return Color(red: 0.78, green: 0.43, blue: 0.93)
        case .pink: return Color(red: 0.93, green: 0.48, blue: 0.73)
        case .rose: return Color(red: 0.95, green: 0.40, blue: 0.56)
        case .orange: return Color(red: 0.95, green: 0.62, blue: 0.35)
        case .green: return Color(red: 0.42, green: 0.78, blue: 0.60)
        case .blue: return Color(red: 0.43, green: 0.70, blue: 0.92)
        }
    }
}

final class AppSettings: ObservableObject {
    @Published var themeMode: AppThemeMode {
        didSet { UserDefaults.standard.set(themeMode.rawValue, forKey: "themeMode") }
    }

    @Published var accent: AccentTheme {
        didSet { UserDefaults.standard.set(accent.rawValue, forKey: "accentTheme") }
    }

    init() {
        let savedTheme = UserDefaults.standard.string(forKey: "themeMode") ?? AppThemeMode.system.rawValue
        let savedAccent = UserDefaults.standard.string(forKey: "accentTheme") ?? AccentTheme.purple.rawValue
        self.themeMode = AppThemeMode(rawValue: savedTheme) ?? .system
        self.accent = AccentTheme(rawValue: savedAccent) ?? .purple
    }
}

extension Color {
    static let appBgLight = Color(red: 0.985, green: 0.958, blue: 0.992)
    static let appBgDark = Color(red: 0.020, green: 0.015, blue: 0.035)
    static let cardLight = Color.white.opacity(0.88)
    static let cardDark = Color(red: 0.080, green: 0.055, blue: 0.115).opacity(0.92)
    static let borderLight = Color(red: 0.88, green: 0.79, blue: 0.92)
    static let borderDark = Color(red: 0.27, green: 0.18, blue: 0.34)
    static let titleLight = Color(red: 0.28, green: 0.16, blue: 0.42)
    static let titleDark = Color(red: 0.91, green: 0.72, blue: 0.98)
    static let secondaryDark = Color(red: 0.69, green: 0.60, blue: 0.78)
}
