//
//  WeatherServiceTests.swift
//  WeatherCoreTests
//
//  Created by Qazi on 05/01/2025.
//

import Testing
@testable import WeatherCore

final class WeatherServiceTests {
    
    var repository: MockWeatherRepository?
    var delegate: MockWeatherSDKDelegate?
    var service: WeatherService?
    
    init() async throws {
        
        let mockDecorder = MockDecoder()
        let mockAPI = MockAPIClient(decoder: mockDecorder)
        let mockRequestBuilder = MockRequestBuilder(
            configurations: Configurations(apiKey: "apikey", cityName: "Berlin")
        )
        repository = MockWeatherRepository(apiClient: mockAPI, requestBuilder: mockRequestBuilder)
        delegate = MockWeatherSDKDelegate()
    }
        
    @Test
    func testLoadCurrentWeather() async {
        guard var repository = repository, let delegate = delegate else {
            #expect(repository != nil && delegate != nil, "Dependencies not initialized")
            return
        }
        repository.currentWeatherResponse = MockWeatherData.getDataForCurrentWeather()
        service = WeatherService(weatherSDKDelegate: delegate, repository: repository)
        
        let result = try? await service?.loadCurrentWeather()
        
        #expect(result?.cityName == "The weather in Berlin is:")
        #expect(result?.formatedTemp == "23°C")
        #expect(result?.skyCondition == "Cloud")
    }
    
    @Test
    func testLoadCurrentWeather_InvalidResponse() async {
        guard let repository = repository, let delegate = delegate else {
            #expect(repository != nil && delegate != nil, "Dependencies not initialized")
            return
        }

        service = WeatherService(weatherSDKDelegate: delegate, repository: repository)
        await #expect(performing: {
            try await service?.loadCurrentWeather()
        }, throws: { error in
            error as? AppError == .invalidResponse
        })
    }
    
    @Test
    func testLoadWeatherForecast() async {
        guard var repository = repository, let delegate = delegate else {
            #expect(repository != nil && delegate != nil, "Dependencies not initialized")
            return
        }

        repository.forecastResponse = MockWeatherData.getDataForWeatherForecast()
        service = WeatherService(weatherSDKDelegate: delegate, repository: repository)
        
        let result = try? await service?.loadWeatherForecast()
        #expect(result?.isEmpty == true)
        // realtime timestamp needed
    }
    
    @Test
    func testDismissWeatherSDK() {
        guard let repository = repository, let delegate = delegate else {
            #expect(repository != nil && delegate != nil, "Dependencies not initialized")
            return
        }

        let service = WeatherService(weatherSDKDelegate: delegate, repository: repository)
        service.dismissWeatherSDK(error: nil)
        #expect(delegate.onFinishedCalled == true)
    }
    
    deinit {
        repository = nil
        delegate = nil
        service = nil
    }
}
