//
//  CurrentWeatherView.swift
//  WeatherCore
//
//  Created by Qazi on 06/01/2025.
//

import SwiftUI

struct CurrentWeatherView: View {
    let currentWeather: WeatherDisplayData?
    
    var body: some View {
        Group {
            if let weather = currentWeather {
                VStack(spacing: 8) {
                    Text(weather.cityName ?? "")
                        .font(.subheadline)
                    Text(weather.formatedTemp)
                        .font(.system(size: 48, weight: .bold))
                    Text(weather.skyCondition)
                        .font(.body)
                    Text("AT \(weather.fomattedTime)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
            } else {
                // Loader
                ProgressView("Loading current weather...")
                    .padding()
            }
        }
    }
}

#Preview {
    CurrentWeatherView(currentWeather: WeatherDisplayData(
        cityName: "Berlin",
        formatedTemp: "20°",
        fomattedTime: "AT LOCAL TIME 16:00)",
        skyCondition: "Clear")
    )
}
