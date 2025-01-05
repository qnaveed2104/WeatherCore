//
//  MockRequestBuilder.swift
//  WeatherCore
//
//  Created by Qazi on 05/01/2025.
//
import Foundation
@testable import WeatherCore

class MockRequestBuilder: WeatherCore.WeatherRequestBuilderProtocol {
    var configurations: WeatherCore.Configurations
    
    init(configurations: WeatherCore.Configurations) {
        self.configurations = configurations
    }
    func buildCurrentWeatherURLRequest() throws -> URLRequest {
        if let url = URL(string: "invalid") {
            return URLRequest(url: url)
        } else {
            throw AppError.invalidUrl(description: "")  // Return nil if the URL cannot be constructed
        }
    }
    
    func buildweatherForecastURLRequest() throws -> URLRequest {
        if let url = URL(string: "invalid") {
            return URLRequest(url: url)
        } else {
            throw AppError.invalidUrl(description: "")  // Return nil if the URL cannot be constructed
        }
    }
}
