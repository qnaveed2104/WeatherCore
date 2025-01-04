//
//  WeatherRepository.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation

protocol WeatherRepositoryProtocol {
    var apiClient: APIClientProtocol { get }
    var requestBuilder: WeatherRequestBuilderProtocol { get }
    func fetchCurrentWeather() async throws -> WeatherResponse
}

struct WeatherRepository: WeatherRepositoryProtocol {
    var requestBuilder: WeatherRequestBuilderProtocol
    let apiClient: APIClientProtocol
    init(apiClient: APIClientProtocol = APIClient(), builder: WeatherRequestBuilderProtocol) {
        self.apiClient = apiClient
        self.requestBuilder = builder
    }
    
    func fetchCurrentWeather() async throws -> WeatherResponse {
        do {
            let urlCurrentWeather = try requestBuilder.buildCurrentWeatherURLRequest()
        
            let result = await apiClient.getDataFromServer(
                  urlRequest: urlCurrentWeather,
                  responseType: WeatherResponse.self)
            
            switch result {
                
            case .success(let weatherResponse):
                return weatherResponse
                
            case .failure(let error):
                throw error
            }
            
        } catch {
            throw error
        }
    }
}
