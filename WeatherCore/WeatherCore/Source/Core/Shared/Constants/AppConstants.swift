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
        static let weatherForcastEndpoint: String = "/forecast/hourly"
        static let apiKey: String = "key"
        static let cityKey: String = "city"
        static let langKey: String = "lang"
        static let hoursKey: String = "hours"

        static func urlFromEndpoint(endpoint: String, version: String = versionTwo) -> String {
            return "\(version)\(endpoint)"
        }
    }
    
    // MARK: - Error Messages
    struct ErrorMessages {
        static let invalidBaseUrlMessage: String = "Base URL is not valid"
        static let invalidURL: String = "Invalid URL"
    }
    
    struct DisplayFormats {
        static let temperature = "%.0f°C"
        static let lcoalTime: String = "AT %@ LOCAL TIME"
        static let formatedCityName: String = "The Weather in %@ is:"
    }
    
    struct DateFormats {
        static let TimeFormat: String = "HH:mm"
    }
}
