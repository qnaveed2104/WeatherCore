//
//  WeatherAPIRequestBuilder.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//
import Foundation

protocol WeatherRequestBuilderProtocol: APIClientRequestBuilderProtocol {
    
    var configurations: Configurations { get }
    func buildCurrentWeatherURLRequest() throws -> URLRequest
}

struct WeatherRequestBuilder: WeatherRequestBuilderProtocol {
    let configurations: Configurations
        
    func buildCurrentWeatherURLRequest() throws -> URLRequest {
        return try buildURLRequest(
            path: AppConstants.API.urlFromEndpoint(endpoint: AppConstants.API.currentWeatherEndpoint),
            queryParams: [
                AppConstants.API.apiKey: configurations.apiKey,
                AppConstants.API.cityKey: configurations.cityName,
                AppConstants.API.langKey: configurations.language ?? "en"
            ]
        )
    }
    
}
