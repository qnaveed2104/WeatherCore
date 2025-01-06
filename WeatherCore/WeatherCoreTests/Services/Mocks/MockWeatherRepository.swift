//
//  MockWeatherRepository.swift
//  WeatherCoreTests
//
//  Created by Qazi on 05/01/2025.
//

import Foundation
import Testing

@testable import WeatherCore

struct MockWeatherRepository: WeatherRepositoryProtocol {
    let apiClient: WeatherCore.APIClientProtocol
    let requestBuilder: WeatherCore.WeatherRequestBuilderProtocol
    var currentWeatherResponse: WeatherResponse?
    var forecastResponse: WeatherResponse?
    func fetchCurrentWeather() async throws -> WeatherCore.WeatherResponse {
        if let response = currentWeatherResponse {
            return response
        }
        throw AppError.invalidResponse
    }
    
    func fetchWeatherForcast() async throws -> WeatherCore.WeatherResponse {
        if let response = forecastResponse {
            return response
        }
        throw AppError.invalidResponse
    }
}
