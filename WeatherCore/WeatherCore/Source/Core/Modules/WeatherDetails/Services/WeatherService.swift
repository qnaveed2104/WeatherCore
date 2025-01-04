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
        
        let formatedTemp = String(format: AppConstants.DisplayFormats.temperature, weatherResponse.temp)
        let formatedTime = formatUnixTimestamp(weatherResponse.ts)

        return WeatherDisplayData(
            cityName: weatherResponse.cityName ?? "NA",
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
