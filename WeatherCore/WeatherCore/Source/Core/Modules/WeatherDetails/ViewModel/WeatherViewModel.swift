//
//  WeatherViewModel.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation

protocol WeatherViewModelProtocol: ObservableObject {
    var service: WeatherServiceProtocol { get }
    func fetchWeatherData() async
}

class WeatherViewModel: WeatherViewModelProtocol {
    let service: WeatherServiceProtocol
    
    init(service: WeatherServiceProtocol) {
        self.service = service
    }
        
    func fetchWeatherData() async {
        do {
            async let currentWeather = service.loadCurrentWeather()
            async let weatherForecast = service.loadWeatherForecast()
            let (currentWeatherData, weatherForecastDate) = try await (currentWeather, weatherForecast)
            
            print("sdffsdf")
        } catch {
            print(error)
        }
    }
}
