//
//  WeatherService.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation

/// A protocol defining the methods for interacting with the weather data service.
protocol WeatherServiceProtocol {
    var repository: WeatherRepositoryProtocol { get }
    var weatherSDKDelegate: WeatherSDKDelegate { get }
    /// Fetches the current weather data.
    func loadCurrentWeather() async throws -> WeatherDisplayData
    /// Fetches the weather forecast data.
    func loadWeatherForecast() async throws -> [WeatherDisplayData]
    /// Dismisses the Weather SDK and reports any errors.
    func dismissWeatherSDK(error: Error?)
}

/// A struct that implements the `WeatherServiceProtocol` to handle the fetching of weather data.
///
/// It fetches current weather data and weather forecasts from the repository and formats the results
/// into displayable data. It also communicates with the `WeatherSDKDelegate` to report success or errors.
struct WeatherService: WeatherServiceProtocol {
    let weatherSDKDelegate: WeatherSDKDelegate
    let repository: WeatherRepositoryProtocol
    
    /// Fetches the current weather data asynchronously.
    /// - Throws: An error if fetching or processing the data fails.
    /// - Returns: The current weather data to display.
    
    func loadCurrentWeather() async throws -> WeatherDisplayData {
        // Fetch weather data from the repository
        let weatherDataArray = try await fetchWeatherData(fetchOperation: repository.fetchCurrentWeather)
        // Ensure that the fetched data is valid
        guard let weatherData = weatherDataArray.first else {
            throw AppError.invalidResponse
        }
        // Create and return the formatted display data
        return createWeatherDisplayData(from: weatherData, isCurrentWeather: true)
    }
    
    
    /// Fetches the weather forecast data asynchronously.
    /// - Throws: An error if fetching or processing the data fails.
    /// - Returns: A list of weather forecast data to display.
    func loadWeatherForecast() async throws -> [WeatherDisplayData] {
        // Fetch weather data from the repository
        let weatherDataArray = try await fetchWeatherData(fetchOperation: repository.fetchWeatherForcast)
        
        // Get the next full hour, or throw an error if unavailable
        let nextFullHour = try Date.nextHourRoundDate() ?? {
            throw AppError.invalidTime
        }()
        
        // Filter and map the weather data to create display data
        let filteredForecastData = weatherDataArray
            .compactMap { forecast -> WeatherDisplayData? in
                guard
                    let forecastDate = Date.parseForecastTimestamp(forecast.timestampLocal),
                    forecastDate >= nextFullHour
                else {
                    return nil
                }
                return createWeatherDisplayData(from: forecast, isCurrentWeather: false)
            }
            .prefix(24)
        
        return Array(filteredForecastData)
    }
    
    /// Dismisses the Weather SDK and reports success or failure to the delegate.
    /// - Parameter error: The error that occurred, if any.
    func dismissWeatherSDK(error: Error?) {
        if let error = error {
            // Report the error to the delegate
            weatherSDKDelegate.onFinishedWithError(error)
        } else {
            // Indicate that the operation finished successfully
            weatherSDKDelegate.onFinished()
        }
    }
    
    // Private helper method to fetch weather data using the repository.
    private func fetchWeatherData(
        fetchOperation: () async throws -> WeatherResponse
    ) async throws -> [WeatherData] {
        let weatherResponse = try await fetchOperation()
        // Ensure the fetched data is not empty
        guard let data = weatherResponse.data, !data.isEmpty else {
            throw AppError.invalidResponse
        }
        return data
    }
    
    // Private helper method to create formatted display data from raw weather data.
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
    
    // Private helper method to format Unix timestamp into a readable string.
    private func formatUnixTimestamp(_ timestamp: Int?) -> String {
        guard let timestamp = timestamp else {
            return "NA"
        }
        let time = Date.timeFromUnixTimestamp(timestamp: TimeInterval(timestamp))
        return String(format: AppConstants.DisplayFormats.lcoalTime, time)
    }
}
