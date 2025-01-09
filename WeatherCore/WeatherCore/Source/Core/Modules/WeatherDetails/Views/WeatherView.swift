//
//  WeatherView.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import SwiftUI

/// A view that displays weather data, including current weather and forecast, using the `WeatherViewModel`.
struct WeatherView: View {
    // ViewModel responsible for managing the weather data.
    @ObservedObject var viewModel: WeatherViewModel
    // Environment variable to handle view dismissal.
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            // Displays the app's state, transitioning through different UI states.
            AppStateView(
                state: viewModel.state,
                content: { weatherDetails in
                    VStack {
                        // Current weather display view
                        CurrentWeatherView(currentWeather: weatherDetails.currentWeather)
                        // Forecast weather list view
                        ForecastListView(weatherForecast: weatherDetails.weatherForecast)
                    }
                }
            )
            // Set background color for the view
            .background(AppColors.primaryBackground.color)
            // Set background color for the navigation bar
            .toolbarBackground(AppColors.navBarColor.color, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            // Set navigation bar title
            .navigationBarTitle(AppConstants.DisplayMessages.header, displayMode: .inline)
            .toolbar {
                // Add back button to navigation bar
                ToolbarItem(placement: .navigationBarLeading) {
                    backButton
                }
            }
        }
        .background(AppColors.primaryBackground.color)
    }
    
    // Function to handle view dismissal
    private var backButton: some View {
        Button(action: dismissView) {
            HStack {
                Image(systemName: AppConstants.SysImagesNames.backImage)
                    .font(ThemeFonts.title())
                WeatherViewWithTheme(
                    AppConstants.DisplayMessages.backButton,
                    style: .textRegular,
                    color: AppColors.accent.color
                )
            }
            .tint(AppColors.accent.color)
        }
    }
    
    private func dismissView() {
        viewModel.dismissSDK()
        presentationMode.wrappedValue.dismiss() // Custom back button action (pop the view)
    }
}
