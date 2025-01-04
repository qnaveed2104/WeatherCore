//
//  WeatherService.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation

protocol WeatherServiceProtocol {
    var repository: WeatherRepositoryProtocol { get }
    func loadCurrentWeather() async throws -> WeatherDisplayData
    func loadWeatherForecast() async throws -> [WeatherDisplayData]

}

struct WeatherService: WeatherServiceProtocol {
   
    let repository: WeatherRepositoryProtocol
        
    func loadCurrentWeather() async throws -> WeatherDisplayData {
        let weatherDataArray = try await fetchWeatherData {
            try await repository.fetchCurrentWeather()
        }
        return try getWeatherDisplayDate(weatherResponse: weatherDataArray.first)
    }
    
    func loadWeatherForecast() async throws -> [WeatherDisplayData] {
        let weatherDataArray = try await fetchWeatherData {
            try await repository.fetchWeatherForcast()
        }
        return try [getWeatherDisplayDate(weatherResponse: weatherDataArray.first)]
    }
    
    private func fetchWeatherData(fetchOperation: () async throws -> WeatherResponse) async throws -> [WeatherData] {
        let weatherResponse = try await fetchOperation()
        guard let weatherDataArray = weatherResponse.data, !weatherDataArray.isEmpty else {
            throw AppError.noWeatherDataAvailable
        }
        return weatherDataArray
    }
    
    private func getWeatherDisplayDate(weatherResponse: WeatherData?) throws -> WeatherDisplayData {
        guard let weatherResponse = weatherResponse else {
            throw AppError.invalidWeatherData
        }
        
        let formatedCityName = String(
            format: AppConstants.DisplayFormats.formatedCityName,
            weatherResponse.cityName ?? "NA"
        )
        let formatedTemp = String(format: AppConstants.DisplayFormats.temperature, weatherResponse.temp)
        let formatedTime = formatUnixTimestamp(weatherResponse.ts)

        return WeatherDisplayData(
            cityName: formatedCityName,
            formatedTemp: formatedTemp,
            fomattedTime: formatedTime,
            skyCondition: weatherResponse.weather.description
        )
    }
    
    private func formatUnixTimestamp(_ timestamp: Int?) -> String {
            guard let timestamp = timestamp else {
                return "NA"
            }
            let time = Date.timeFromUnixTimestamp(timestamp: TimeInterval(timestamp))
            return String(format: AppConstants.DisplayFormats.lcoalTime, time)
        }
}
