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
            path: API.urlFromEndpoint(endpoint: API.EndPoints.currentWeather),
            queryParams: nil
        )
    }
    
}
