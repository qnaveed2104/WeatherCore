//
//  WeatherServiceTests.swift
//  WeatherCoreTests
//
//  Created by Qazi on 05/01/2025.
//

import Testing
@testable import WeatherCore

final class WeatherServiceTests {
    
    var repository: MockWeatherRepository
    var delegate: MockWeatherSDKDelegate
    var service: WeatherService?
    
    init() async throws {
        
        let mockDecorder = MockDecoder()
        let mockAPI = MockAPIClient(decoder: MockDecoder())
        let mockRequestBuilder = MockRequestBuilder(
            configurations: Configurations(apiKey: "apikey", cityName: "Berlin", hours: 24)
        )
        repository = MockWeatherRepository(apiClient: mockAPI, requestBuilder: mockRequestBuilder)
        delegate = MockWeatherSDKDelegate()
        service = WeatherService(weatherSDKDelegate: delegate, repository: repository)
    }
    
    deinit {
        service = nil
    }
}
