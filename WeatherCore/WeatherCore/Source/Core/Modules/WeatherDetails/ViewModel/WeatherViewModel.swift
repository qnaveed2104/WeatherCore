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

class WeatherViewModel: WeatherViewModelProtocol, AppStateProtocol {
    typealias ContentType = WeatherDetails
    var state: AppState<WeatherDetails>
    var currentWeather: WeatherDisplayData?
    var weatherForecast: [WeatherDisplayData] = []
    
    let service: WeatherServiceProtocol
    
    init(service: WeatherServiceProtocol) {
        self.service = service
        self.state = .idle
    }
    
    func fetchWeatherData() async {
        do {
            async let currentWeatherTask: WeatherDisplayData? = loadCurrentWeather()
            async let weatherForecastTask: [WeatherDisplayData] =  loadWeatherForecast()
            
            let (currentWeather, weatherForecast) = try await (currentWeatherTask, weatherForecastTask)
            let weatherDetails = WeatherDetails(currentWeather: currentWeather, weatherForecast: weatherForecast)
            
            if weatherDetails.isEmpty {
                self.state = .empty
            } else {
                self.state = .success(weatherDetails)
            }
            
        } catch {
            self.state = .failed(error as? AppError ?? AppError.unknownError)
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
