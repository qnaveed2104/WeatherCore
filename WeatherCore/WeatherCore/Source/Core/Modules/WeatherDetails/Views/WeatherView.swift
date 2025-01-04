//
//  WeatherView.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel = WeatherViewModel()

    var body: some View {
        Text("Hello from WeatherView")
    }
}

#Preview {
    WeatherView()
}
