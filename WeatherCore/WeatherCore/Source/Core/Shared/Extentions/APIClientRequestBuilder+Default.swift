//
//  APIRequestBuilder+Default.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation
protocol APIClientRequestBuilderProtocol {
    
    var baseUrl: String { get }
    func buildURLRequest(
        path: String,
        queryParams: [String: String]?
    ) throws -> URLRequest
}

extension APIClientRequestBuilderProtocol {
 
    var baseUrl: String {
        API.baseUrl
    }
   
    func buildURLRequest(
        path: String,
        queryParams: [String: String]?
    ) throws -> URLRequest {
        
        guard var components = URLComponents(string: baseUrl) else {
            throw AppError.invalidBaseUrl(description: AppResources.Constants.invalidBaseUrlMessage)
        }
        
        components.path = path
        
        if let queryParams = queryParams {
            components.queryItems = queryParams.map {
                URLQueryItem(
                    name: $0.key,
                    value: $0.value
                )
            }
        }
        
        guard let url = components.url else {
            throw AppError.invalidUrl(description: AppResources.Constants.invalidURL)
        }
        
        return URLRequest(url: url)
    }
}
