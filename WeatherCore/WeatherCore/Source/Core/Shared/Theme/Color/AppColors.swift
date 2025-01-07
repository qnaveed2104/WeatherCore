//
//  AppColors.swift
//  WeatherCore
//
//  Created by Qazi on 07/01/2025.
//

import SwiftUI

enum AppColors {
    case accent
    case accentHighlighted
    case textPrimary
    case textSecondary
    case textPlaceholder
    case textBorder
    case navBarColor
    
    var color: Color {
        switch self {
        case .accent:
            return Color("Accent")
        case .accentHighlighted:
            return Color("AccentHighlighted")
        case .textPrimary:
            return Color("TextPrimary")
        case .textSecondary:
            return Color("TextSecondary")
        case .textPlaceholder:
            return Color("TextPlaceholder")
        case .textBorder:
            return Color("TextBorder")
        case .navBarColor:
            return Color("NavBarColor")
        }
    }
}
