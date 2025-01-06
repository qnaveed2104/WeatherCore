//
//  WeatherViewModel.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation

protocol WeatherViewModelProtocol: ObservableObject {
    var service: WeatherServiceProtocol { get }
    var currentWeather: WeatherDisplayData? { get set}
    var weatherForecast: [WeatherDisplayData] { get set}

    func fetchWeatherData() async
    func dismissSDK()
}

class WeatherViewModel: WeatherViewModelProtocol {
    var currentWeather: WeatherDisplayData?
    var weatherForecast: [WeatherDisplayData] = []
    
    let service: WeatherServiceProtocol
    
    init(service: WeatherServiceProtocol) {
        self.service = service
    }
    
    func fetchWeatherData() async {
        do {
            async let currentWeatherTask: WeatherDisplayData? = loadCurrentWeather()
            async let weatherForecastTask: [WeatherDisplayData] =  loadWeatherForecast()
            
            if let weather = try await currentWeatherTask {
                self.currentWeather = weather
            }
            
            self.weatherForecast = try await weatherForecastTask
            
        } catch {
            print(error)
        }
    }
    
    private func loadCurrentWeather() async throws -> WeatherDisplayData? {
        return try await service.loadCurrentWeather()
    }
    
    private func loadWeatherForecast() async throws -> [WeatherDisplayData] {
        return try await service.loadWeatherForecast()
    }
    
    func dismissSDK() {
        service.dismissWeatherSDK()
    }
}
