//
//  MockWeatherSDKDelegate.swift
//  WeatherCore
//
//  Created by Qazi on 05/01/2025.
//

@testable import WeatherCore

final class MockWeatherSDKDelegate: WeatherSDKDelegate {
    
    var onFinishedCalled: Bool = false
    
    func onFinished() {
        onFinishedCalled = true
    }
    
    func onFinishedWithError(_ error: any Error) {
        onFinishedCalled = true
    }
}
