//
//  WeatherSDK.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation
import SwiftUI

/// A class that connects to the Weather SDK to get weather details for a city.
///
/// This class stores the API key and city name to set up the configuration.
/// It provides a method to display a weather details view and informs the delegate about the results.
public final class WeatherSDK {
    
    // MARK: - Properties
    
    /// Stores the configuration settings, such as API key and city name.
    public var configuration: Configurations
    
    /// Notifies the delegate about the completion of weather data fetch or errors.
    public weak var delegate: WeatherSDKDelegate?
    
    /// Initializes the WeatherSDK with configuration and delegate.
    /// - Parameters:
    ///   - configuration: Includes the API key and city name.
    ///   - delegate: An object that receives updates about the data fetch status.
    /// - Throws: An error if the API key or city name is empty.
    public init(configuration: Configurations, delegate: WeatherSDKDelegate) throws {
        guard !configuration.apiKey.isEmpty else { throw AppError.invalidAPIKey }
        guard !configuration.cityName.isEmpty else { throw AppError.invalidCityName }
        self.configuration = configuration
        self.delegate = delegate
    }
    
    /// Creates a view that shows the weather details of a city.
    /// - Returns: A view displaying the weather information.
    func getWeather() -> AnyView {
        let viewModel = createWeatherViewModel()
        return AnyView(WeatherView(viewModel: viewModel))
    }
    
    /// Prepares the view model for fetching and displaying weather data.
    /// - Returns: A `WeatherViewModel` configured to fetch and manage weather data.
    private func createWeatherViewModel() -> WeatherViewModel {
        let apiClient: APIClientProtocol = APIClient()
        let requestBuilder: WeatherRequestBuilderProtocol = WeatherRequestBuilder(configurations: configuration)
        let weatherRepository: WeatherRepositoryProtocol = WeatherRepository(
            apiClient: apiClient,
            builder: requestBuilder
        )
        let weatherservice: WeatherServiceProtocol = WeatherService(
            weatherSDKDelegate: self,
            repository: weatherRepository
        )
        let viewModel: WeatherViewModel =  WeatherViewModel(service: weatherservice)
        Task {
            await viewModel.fetchWeatherData()
        }
        return viewModel
    }
}

extension WeatherSDK: WeatherSDKDelegate {
    /// Notifies the delegate when weather data fetch is successfully finished.
    public func onFinished() {
        delegate?.onFinished()
    }
    
    /// Notifies the delegate when an error occurs while fetching weather data.
    /// - Parameter error: The error that occurred during the process.
    public func onFinishedWithError(_ error: any Error) {
        delegate?.onFinishedWithError(error)
    }
}
