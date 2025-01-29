//
//  MockDecoder.swift
//  WeatherCore
//
//  Created by Qazi on 05/01/2025.
//
import Foundation
@testable import WeatherCore

class MockDecoder: WeatherCore.DecoderProtocol {
    func decodeAPIError(data: Data) throws -> String {
        return ""
    }
    
    func decodeObject<T>(
        objectType: T.Type, data: Data
    ) throws -> T where T: Decodable {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
