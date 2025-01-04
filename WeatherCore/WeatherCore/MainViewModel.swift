//
//  MainViewModel.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import SwiftUI
class MainViewModel: ObservableObject {
    var weatherSdk: WeatherSDK?

    init(weatherSdk: WeatherSDK? = nil) {
        self.weatherSdk = weatherSdk
    }
    
    func getWeatherSDKView( ) -> AnyView {
        return AnyView(weatherSdk?.getWeather())
    }
}
