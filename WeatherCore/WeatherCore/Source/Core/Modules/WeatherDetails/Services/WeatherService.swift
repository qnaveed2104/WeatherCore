//
//  WeatherService.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation

protocol WeatherServiceProtocol {
    var repository: WeatherRepositoryProtocol { get }
    var weatherSDKDelegate: WeatherSDKDelegate { get }
    func loadCurrentWeather() async throws -> WeatherDisplayData
    func loadWeatherForecast() async throws -> [WeatherDisplayData]
    
}

struct WeatherService: WeatherServiceProtocol {
    let weatherSDKDelegate: WeatherSDKDelegate
    let repository: WeatherRepositoryProtocol
    
    func loadCurrentWeather() async throws -> WeatherDisplayData {
        let weatherDataArray = try await fetchWeatherData(fetchOperation: repository.fetchCurrentWeather)
        guard let weatherData = weatherDataArray.first else {
            throw AppError.invalidResponse
        }
        return createWeatherDisplayData(from: weatherData, isCurrentWeather: true)
    }
    
    func loadWeatherForecast() async throws -> [WeatherDisplayData] {
        let weatherDataArray = try await fetchWeatherData(fetchOperation: repository.fetchWeatherForcast)
        return weatherDataArray.map {
            createWeatherDisplayData(from: $0, isCurrentWeather: false)
        }
    }
    
    private func fetchWeatherData(
        fetchOperation: () async throws -> WeatherResponse
    ) async throws -> [WeatherData] {
        let weatherResponse = try await fetchOperation()
        guard let data = weatherResponse.data, !data.isEmpty else {
            throw AppError.invalidResponse
        }
        return data
    }
    
    private func createWeatherDisplayData(from data: WeatherData, isCurrentWeather: Bool) -> WeatherDisplayData {
        WeatherDisplayData(
            cityName: isCurrentWeather
            ? String(format: AppConstants.DisplayFormats.formatedCityName, data.cityName ?? "NA")
            : (nil),
            formatedTemp: String(format: AppConstants.DisplayFormats.temperature, data.temp),
            fomattedTime: (isCurrentWeather
                           ? formatUnixTimestamp(data.ts)
                           : data.timestampLocal?.getlocalTime()
                          ) ?? "NA",
            skyCondition: data.weather.description
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
