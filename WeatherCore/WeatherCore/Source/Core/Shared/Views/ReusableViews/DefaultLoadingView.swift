//
//  DefaultLoadingView.swift
//  WeatherCore
//
//  Created by Qazi on 06/01/2025.
//

import SwiftUI

struct DefaultLoadingView: View {
    var loadingText: String = "Loading..."
    var paddingAmount: CGFloat = 16.0
    var body: some View {
        VStack {
            ProgressView(loadingText)
                .progressViewStyle(CircularProgressViewStyle())
                .padding(paddingAmount)
        }
    }
}

#Preview {
    DefaultLoadingView()
}
