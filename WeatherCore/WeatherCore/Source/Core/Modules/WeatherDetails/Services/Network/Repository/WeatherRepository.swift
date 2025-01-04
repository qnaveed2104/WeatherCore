//
//  WeatherRepository.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation

protocol WeatherRepositoryProtocol {
    var apiCleint: APIClientProtocol { get }
    func fetchCurrentWeather() async
}

struct WeatherRepository: WeatherRepositoryProtocol {
    let apiCleint: APIClientProtocol
    
    init(apiCleint: APIClientProtocol = APIClient()) {
        self.apiCleint = apiCleint
    }
    func fetchCurrentWeather() async {
     
      _ = await apiCleint.getDataFromServer(
            urlRequest: URLRequest(
                url: URL(
                    string: "https://google.com")!
            ),
            responseType: WeatherData.self)
    }
}

struct WeatherData: Codable {
    let city: String
}
