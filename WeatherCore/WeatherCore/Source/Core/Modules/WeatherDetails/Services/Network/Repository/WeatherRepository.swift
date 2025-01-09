//
//  WeatherRepository.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation

/// A protocol that defines the methods to interact with the weather data repository.
protocol WeatherRepositoryProtocol {
    var apiClient: APIClientProtocol { get }
    var requestBuilder: WeatherRequestBuilderProtocol { get }
    /// Fetches the current weather data.
    func fetchCurrentWeather() async throws -> WeatherResponse
    /// Fetches the weather forecast data.
    func fetchWeatherForcast() async throws -> WeatherResponse
}

/// A struct that implements the `WeatherRepositoryProtocol` to handle fetching weather data.
struct WeatherRepository: WeatherRepositoryProtocol {
    var requestBuilder: WeatherRequestBuilderProtocol
    let apiClient: APIClientProtocol
    // Initializes the repository with an API client and request builder.
    init(apiClient: APIClientProtocol = APIClient(), builder: WeatherRequestBuilderProtocol) {
        self.apiClient = apiClient
        self.requestBuilder = builder
    }
    
    /// Fetches the current weather data asynchronously.
    /// - Throws: An error if the request fails.
    /// - Returns: A `WeatherResponse` containing the current weather data.
    func fetchCurrentWeather() async throws -> WeatherResponse {
        // Build the URL request for current weather data
        let urlRequestforCurrentWeather = try requestBuilder.buildCurrentWeatherURLRequest()
        // Fetch the weather data from the server
        return try await fetchWeather(urlRequest: urlRequestforCurrentWeather)
    }
    
    /// Fetches the weather forecast data asynchronously.
    /// - Throws: An error if the request fails.
    /// - Returns: A `WeatherResponse` containing the weather forecast data.
    func fetchWeatherForcast() async throws -> WeatherResponse {
        // Build the URL request for weather forecast data
        let urlRequestforWeatherForecast = try requestBuilder.buildweatherForecastURLRequest()
        // Fetch the weather data from the server
        return try await fetchWeather(urlRequest: urlRequestforWeatherForecast)
    }
    
    // Private helper method to fetch weather data from the server.
    private func fetchWeather(urlRequest: URLRequest) async throws -> WeatherResponse {
        // Get the data from the API client
        let result = await apiClient.getDataFromServer(
            urlRequest: urlRequest,
            responseType: WeatherResponse.self
        )
        
        // Handle the result of the API call
        switch result {
        case .success(let weatherResponse):
            return weatherResponse
        case .failure(let error):
            throw error
        }
    }
}
