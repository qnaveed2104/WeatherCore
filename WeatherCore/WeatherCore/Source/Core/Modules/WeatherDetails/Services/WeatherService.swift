//
//  WeatherService.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

protocol WeatherServiceProtocol {
    var repository: WeatherRepositoryProtocol { get }
    func loadCurrentWeather() async throws -> WeatherDisplayData
}

struct WeatherService: WeatherServiceProtocol {
   
    let repository: WeatherRepositoryProtocol
        
    func loadCurrentWeather() async throws -> WeatherDisplayData {
        let weatherResponse = try await repository.fetchCurrentWeather()
        guard let weatherDataArray = weatherResponse.data, !weatherDataArray.isEmpty else {
            throw AppError.noWeatherDataAvailable
        }
        return try getWeatherDisplayDate(weatherResponse: weatherDataArray.first)
    }
    
    private func getWeatherDisplayDate(weatherResponse: WeatherData?) throws -> WeatherDisplayData {
        guard let weatherResponse = weatherResponse else {
            throw AppError.invalidWeatherData
        }
        return WeatherDisplayData(cityName: weatherResponse.cityName ?? "NA")
    }
}
