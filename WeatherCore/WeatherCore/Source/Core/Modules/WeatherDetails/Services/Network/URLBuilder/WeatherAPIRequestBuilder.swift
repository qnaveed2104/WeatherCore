//
//  WeatherAPIRequestBuilder.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//
import Foundation

protocol WeatherRequestBuilderProtocol: APIClientRequestBuilderProtocol {
    
    func buildCurrentWeatherURLRequest() throws -> URLRequest
}

struct WeatherRequestBuilder: WeatherRequestBuilderProtocol {
    
    func buildCurrentWeatherURLRequest() throws -> URLRequest {
        return try buildURLRequest(
            path: API.urlFromEndpoint(endpoint: API.EndPoints.currentWeather),
            queryParams: nil
        )
    }
    
}
