//
//  ApiClient.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation

/// Protocol defining the methods required for an API client.
protocol APIClientProtocol {
    
    var decoder: DecoderProtocol { get set }
    
    /// Fetches data from the server.
    /// - Parameters:
    ///   - urlRequest: The request to be sent.
    ///   - responseType: The expected type of the response.
    /// - Returns: A `Result` containing the decoded response or an `AppError`.
    func getDataFromServer<T: Decodable>(
        urlRequest: URLRequest,
        responseType: T.Type
    ) async -> Result<T, AppError>
}

/// Default implementation of `APIClientProtocol`.
struct APIClient: APIClientProtocol {
    /// Decoder used to decode responses from the server.
    var decoder: DecoderProtocol
    
    /// Initializes the API client with a default decoder.
    init(decoder: DecoderProtocol = JSONDataDecoder()) {
        self.decoder = decoder
    }
    /// Fetches data from the server and decodes the response.
    /// - Parameters:
    ///   - urlRequest: The URLRequest to be sent to the server.
    ///   - responseType: The expected type of the response (conforming to `Decodable`).
    /// - Returns: A `Result` containing either the decoded model or an `AppError`.
    func getDataFromServer<T: Decodable>(
        urlRequest: URLRequest,
        responseType: T.Type
    ) async -> Result<T, AppError> {
        
        do {
            // Fetch data from the server
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            // Validate HTTP response
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(AppError.invalidResponse)
            }
            
            let statusCode = httpResponse.statusCode
            
            // Handle non-2xx status codes
            if !(200...299).contains(statusCode) {
                if let errorMessage = try? decoder.decodeAPIError(data: data) {
                    return .failure(AppError.apiError(message: errorMessage))
                } else {
                    // Fallback to a generic HTTP error message
                    return .failure(.httpError(statusCode: statusCode))
                }
            }
            
            // Handle empty data response
            if data.isEmpty {
                return .failure(.httpError(statusCode: statusCode))
            }
            
            // Attempt to decode the response data into the expected model
            do {
                let model = try decoder.decodeObject(objectType: T.self, data: data)
                return .success(model)
            } catch {
                return .failure(AppError.decodingError(error: error))
            }
        } catch {
            return .failure(AppError.networkError(error: error))
        }
    }
}
