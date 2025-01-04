//
//  WeatherViewModel.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation

protocol WeatherViewModelProtocol: ObservableObject {
    var service: WeatherServiceProtocol { get }
}

class WeatherViewModel: WeatherViewModelProtocol {
    let service: WeatherServiceProtocol
    
    init(service: WeatherServiceProtocol) {
        self.service = service
        Task {
            try await self.service.loadWeather()
        }
    }
}
