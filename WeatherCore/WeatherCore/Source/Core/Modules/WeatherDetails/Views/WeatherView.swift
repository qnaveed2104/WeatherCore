//
//  WeatherView.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    var body: some View {
        
        AppStateView(
            state: viewModel.state,
            content: { weatherDetails in
                VStack {
                    CurrentWeatherView(currentWeather: weatherDetails.currentWeather)
                    ForecastListView(weatherForecast: weatherDetails.weatherForecast)
                }
            }
        )

    }
}
