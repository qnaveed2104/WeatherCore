//
//  AppConstants.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

enum AppConstants {
    
    // MARK: - API
    enum API {
        static let baseUrl: String = "https://api.weatherbit.io"
        
        static let versionTwo: String = "/v2.0"
        
        static let currentWeatherEndpoint: String = "/current"
        
        static func urlFromEndpoint(endpoint: String, version: String = versionTwo) -> String {
            return "\(version)\(endpoint)"
        }
    }
    
    // MARK: - Error Messages
       struct ErrorMessages {
           static let invalidBaseUrlMessage: String = "Base URL is not valid"
           static let invalidURL: String = "Invalid URL"
       }
}
