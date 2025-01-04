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
    func fetchCurrentWeather() async
}

struct WeatherRepository: WeatherRepositoryProtocol {
    var requestBuilder: WeatherRequestBuilderProtocol
    let apiClient: APIClientProtocol
    init(apiClient: APIClientProtocol = APIClient(), builder: WeatherRequestBuilderProtocol = WeatherRequestBuilder()) {
        self.apiClient = apiClient
        self.requestBuilder = builder
    }
    func fetchCurrentWeather() async {
     
        do {
            let urlCurrentWeather = try requestBuilder.buildCurrentWeatherURLRequest()
        
            _ = await apiClient.getDataFromServer(
                  urlRequest: urlCurrentWeather,
                  responseType: WeatherData.self)
        } catch {
        }
    }
}

struct WeatherData: Codable {
    let city: String
}
