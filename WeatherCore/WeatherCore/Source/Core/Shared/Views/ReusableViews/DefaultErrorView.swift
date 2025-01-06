//
//  DefaultErrorView.swift
//  WeatherCore
//
//  Created by Qazi on 06/01/2025.
//

import SwiftUI

struct DefaultErrorView: View {
    let error: Error
    var body: some View {
        VStack {
            Text("An error occurred")
                .font(.headline)
                .foregroundColor(.red)
            Text(error.localizedDescription)
                .font(.subheadline)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

#Preview {
    DefaultErrorView(error: AppError.invalidResponse)
}
