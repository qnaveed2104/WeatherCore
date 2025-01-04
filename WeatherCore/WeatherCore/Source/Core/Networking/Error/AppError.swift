//
//  AppError.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

public enum AppError: Error {
    case invalidResponse
    case unknownError
    case decodingError(error: Error)
    case invalidBaseUrl(description: String)
    case invalidUrl(description: String)
    case httpError(statusCode: Int)
    case emptyData
    case githubTokenNotfound
    case noWeatherDataAvailable
    case invalidWeatherData
    case missingCriticalField(String)
}
