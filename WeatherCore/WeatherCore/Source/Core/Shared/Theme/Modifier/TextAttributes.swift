//
//  TextAttributes.swift
//  WeatherCore
//
//  Created by Qazi on 07/01/2025.
//

import SwiftUI

struct ThemedText: ViewModifier {
    let font: Font
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(color)
    }
}

extension View {
    func themedText(font: Font, color: Color) -> some View {
        self.modifier(ThemedText(font: font, color: color))
    }
}
