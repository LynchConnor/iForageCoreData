
import Foundation
import SwiftUI

extension Color {
    static let theme = Theme()
    static let onboarding = OnboardingTheme()
}

struct Theme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let cardBackground = Color("CardBackground")
    let navigationBackground = Color("NavigationBackground")
    let buttonBackgroundColor = Color("ButtonBackgroundColor")
    let exploreBackground = Color("ExploreBackground")
}

struct OnboardingTheme {
    let buttonBackground = Color("ButtonBackground")
    let textfield = Color("TextFieldBackground")
}

