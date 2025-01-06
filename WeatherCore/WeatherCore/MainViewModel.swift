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
        getWeather(apiKey: "f8c11bda6cdc4b0c8ad517e57775cc54", cityName: "Berlin")
    }
    
    func getWeather(apiKey: String, cityName: String) {
        let configuration = Configurations(apiKey: apiKey, cityName: cityName, hours: 24)
        weatherSdk =  try? WeatherSDK(configuration: configuration, delegate: self)
    }
    
    func getCurrentWeatherView() -> AnyView? {
        // Example view, replace with actual logic
        return AnyView(weatherSdk?.getWeather() )
    }
    
    func getWeatherSDKView( ) -> AnyView {
        return AnyView(weatherSdk?.getWeather())
    }
}
extension MainViewModel: WeatherSDKDelegate {
    func onFinished() {
        print("Weather dissmissed")
    }
    
    func onFinishedWithError(_ error: Error) {
        print("Weather dissmissed with error: \(error)")
    }
    
}
