//
//  WeatherCoreApp.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import SwiftUI

@main
struct WeatherCoreApp: App {
    var body: some Scene {
        WindowGroup {
            let weatherSdk: WeatherSDK = WeatherSDK(
                configuration: Configurations(
                    apiKey: "0f9287d7f9cf496e816ff1d9a7563c61",
                    cityName: "Berlin",
                    hours: 24
                )
            )
            let viewModel: MainViewModel = MainViewModel(weatherSdk: weatherSdk)
            ClientAppContentView(viewModel: viewModel)
        }
    }
}
