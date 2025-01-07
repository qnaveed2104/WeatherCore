//
//  WeatherView.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            AppStateView(
                state: viewModel.state,
                content: { weatherDetails in
                    VStack {
                        CurrentWeatherView(currentWeather: weatherDetails.currentWeather)
                        ForecastListView(weatherForecast: weatherDetails.weatherForecast)
                    }
                },
                errorView: { error in
                    DefaultErrorView(error: error)
                }
            )
            .toolbarBackground(AppColors.navBarColor.color, for: .navigationBar) // Change nav bar color
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitle(AppConstants.DisplayMessages.header, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    backButton
                }
            }
        }
    }
    
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
