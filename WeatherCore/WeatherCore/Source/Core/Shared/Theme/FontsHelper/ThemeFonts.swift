//
//  ThemeFonts.swift
//  WeatherCore
//
//  Created by Qazi on 07/01/2025.
//

import SwiftUI

enum ThemeFonts {
    
    enum FontType {
        case heading1, heading2, title, textRegular, label
    }

    static func h1() -> Font { Font.custom(AppConstants.FontNames.bold, size: 28) }
    static func h2() -> Font { Font.custom(AppConstants.FontNames.bold, size: 20) }
    static func title() -> Font { Font.custom(AppConstants.FontNames.bold, size: 16) }
    static func textRegular() -> Font { Font.custom(AppConstants.FontNames.medium, size: 16) }
    static func label() -> Font { Font.custom(AppConstants.FontNames.medium, size: 12) }
    
    static func fontStyle(for type: FontType) -> (font: Font, lineSpacing: CGFloat) {
        switch type {
        case .heading1:
            return (font: h1(), lineSpacing: 36)
        case .heading2:
            return (font: h2(), lineSpacing: 28)
        case .title:
            return (font: title(), lineSpacing: 24)
        case .textRegular:
            return (font: textRegular(), lineSpacing: 24)
        case .label:
            return (font: label(), lineSpacing: 18)
        }
    }
}
