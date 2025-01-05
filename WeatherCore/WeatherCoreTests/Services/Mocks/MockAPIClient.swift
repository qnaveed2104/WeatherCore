//
//  MockAPIClient.swift
//  WeatherCore
//
//  Created by Qazi on 05/01/2025.
//
import Foundation
@testable import WeatherCore

// Mock implementation of the APIClientProtocol
class MockAPIClient: WeatherCore.APIClientProtocol {
    var decoder: any WeatherCore.DecoderProtocol
    
    init(decoder: any WeatherCore.DecoderProtocol) {
        self.decoder = decoder
    }
    
    func getDataFromServer<T: Decodable>(
        urlRequest: URLRequest,
        responseType: T.Type
    ) async -> Result<T, AppError> {
        
        // Return a mocked response
        if T.self == WeatherResponse.self {
            // Safely cast to WeatherResponse if T is WeatherResponse
            let mockResponse = WeatherResponse(count: 0, data: nil, cityName: nil, countryCode: nil)
            
            // Ensure we return the correct type
            if let typedResponse = mockResponse as? T {
                return .success(typedResponse)
            } else {
                return .failure(.invalidResponse)
            }
        } else {
            // Handle other response types if needed
            return .failure(.invalidResponse)  // Or return any other AppError
        }
    }
}
