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
            let weatherSdk: WeatherSDK = WeatherSDK(apiKey: "app_key")
            let viewModel: MainViewModel = MainViewModel(weatherSdk: weatherSdk)
            ClientAppContentView(viewModel: viewModel)
        }
    }
}
