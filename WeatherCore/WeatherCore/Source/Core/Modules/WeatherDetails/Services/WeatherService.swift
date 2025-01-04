//
//  WeatherService.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

protocol WeatherServiceProtocol {
    var repository: WeatherRepositoryProtocol { get }
    func loadWeather() async
}

struct WeatherService: WeatherServiceProtocol {
   
    let repository: WeatherRepositoryProtocol
    
    init(repository: WeatherRepositoryProtocol = WeatherRepository()) {
        self.repository = repository
    }
    
    func loadWeather() async {
        await repository.fetchCurrentWeather()
    }
}
