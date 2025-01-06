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
        let mockAPI = MockAPIClient(decoder: mockDecorder)
        let mockRequestBuilder = MockRequestBuilder(
            configurations: Configurations(apiKey: "apikey", cityName: "Berlin", hours: 24)
        )
        repository = MockWeatherRepository(apiClient: mockAPI, requestBuilder: mockRequestBuilder)
        delegate = MockWeatherSDKDelegate()
    }
    
    @Test
    func testLoadCurrentWeather() async {
        repository.currentWeatherResponse = MockWeatherData.getData()
        service = WeatherService(weatherSDKDelegate: delegate, repository: repository)

        let result = try? await service?.loadCurrentWeather()

        #expect(result?.cityName == "The Weather in Berlin is:")
        #expect(result?.fomattedTime == "AT 18:00 LOCAL TIME")
        #expect(result?.formatedTemp == "23°C")
        #expect(result?.skyCondition == "Clouds")
    }
    
    deinit {
        service = nil
    }
}
