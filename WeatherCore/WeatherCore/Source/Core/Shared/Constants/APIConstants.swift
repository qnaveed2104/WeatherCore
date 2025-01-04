//
//  AppConstants.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

enum API {
    static let baseUrl: String = "https://api.weatherbit.io"
    
    enum Version {
        static let versionTwo: String = "/v2.0"
    }
    
    enum EndPoints {
        static let currentWeather: String = "/current"
    }
    
    static func urlFromEndpoint(endpoint: String, version: String = Version.versionTwo) -> String {
        return "\(version)\(endpoint)"
    }
}
