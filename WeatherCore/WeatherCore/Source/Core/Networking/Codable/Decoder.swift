//
//  Decoder.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation

/// Protocol that defines methods for decoding objects and handling API error responses.
protocol DecoderProtocol {
    /// Decodes the given data into the specified type.
    /// - Parameters:
    ///   - objectType: The type of object to decode.
    ///   - data: The data to decode into the object.
    /// - Returns: The decoded object of type `T`.
    /// - Throws: `DecodingError` if the decoding fails.
    func decodeObject<T: Decodable>(objectType: T.Type, data: Data) throws -> T
    
    /// Decodes the API error message from the response data.
    /// - Parameter data: The error response data.
    /// - Returns: The decoded error message as a `String`.
    /// - Throws: `AppError.invalidResponse` if unable to decode the error message.
    func decodeAPIError(data: Data) throws -> String
}

/// A concrete implementation of `DecoderProtocol` for decoding JSON data.
struct JSONDataDecoder: DecoderProtocol {
    
    // JSONDecoder instance for decoding
    private let decoder: JSONDecoder
    
    // Initializes the decoder with a custom JSONDecoder
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    /// Decodes the given data into the specified object type.
    /// - Parameters:
    ///   - objectType: The type of object to decode.
    ///   - data: The data to decode.
    /// - Returns: The decoded object of type `T`.
    /// - Throws: `DecodingError` if decoding fails.
    func decodeObject<T>(objectType: T.Type, data: Data) throws -> T where T: Decodable {
        return try decoder.decode(T.self, from: data)
    }
    
    /// Decodes the API error message from the given error response data.
    /// - Parameter data: The error response data.
    /// - Returns: The error message.
    /// - Throws: `AppError.invalidResponse` if the error message cannot be decoded.
    func decodeAPIError(data: Data) throws -> String {
        let errorResponse = try decoder.decode([String: String].self, from: data)
        if let errorMessage = errorResponse["error"] {
            return errorMessage
        } else {
            throw AppError.invalidResponse
        }
    }
}
