//
//  MainViewModel.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import SwiftUI
import WeatherConnect
class MainViewModel: ObservableObject {
    var weatherSdk: WeatherSDK?
    @Published var isWeatherViewPresented: Bool = false

    init(weatherSdk: WeatherSDK? = nil) {
        self.weatherSdk = weatherSdk
        getWeather(apiKey: "f8c11bda6cdc4b0c8ad517e57775cc54", cityName: "Berlin")
    }
    
    func getWeather(apiKey: String, cityName: String) {
        let configuration = Configurations(apiKey: apiKey, cityName: cityName)
        weatherSdk =  try? WeatherSDK(configuration: configuration, delegate: self)
    }
    
    func getWeatherView() async -> AnyView? {
        guard let sdk = weatherSdk else { return nil }
        return await sdk.getWeather()
    }
    
}
extension MainViewModel: WeatherSDKDelegate {
    func onFinished() {
        print("Weather dissmissed")
    }
    
    func onFinishedWithError(_ error: Error) {
        print("Weather dissmissed with error: \(error.localizedDescription)")
    }
    
}
