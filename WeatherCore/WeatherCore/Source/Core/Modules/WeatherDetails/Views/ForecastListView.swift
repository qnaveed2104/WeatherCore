//
//  ForecastListView.swift
//  WeatherCore
//
//  Created by Qazi on 06/01/2025.
//

import SwiftUI

struct ForecastListView: View {
    let weatherForecast: [WeatherDisplayData]
    
    var body: some View {
            if weatherForecast.isEmpty {
                // Show a loader when the forecast is empty
                ProgressView("Loading forecast...")
                    .padding()
            } else {
                // Display a list of forecasts
                List(weatherForecast, id: \.fomattedTime) { forecast in
                    // Replace with your actual layout for forecast items
                    WeatherRow(forecast: forecast)
                }
                .listStyle(PlainListStyle())

            }
        }
    
}

#Preview {
    ForecastListView(weatherForecast: [WeatherDisplayData(
        cityName: "Berlin",
        formatedTemp: "20°",
        fomattedTime: "AT LOCAL TIME 16:00)",
        skyCondition: "Clear")])
}

