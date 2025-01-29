//
//  WeatherViewModel.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation

/// A protocol that defines the requirements for a WeatherViewModel.
protocol WeatherViewModelProtocol: ObservableObject {
    var service: WeatherServiceProtocol { get }
    var currentWeather: WeatherDisplayData? { get set}
    var weatherForecast: [WeatherDisplayData] { get set}
    /// Fetches the weather data (current weather and forecast).
    func fetchWeatherData() async
    /// Dismisses the Weather SDK, handling any errors if present.
    func dismissSDK()
}

/// A class that manages weather data for the view and interacts with the WeatherService.
///
/// It loads current weather and weather forecast asynchronously and manages the state of the view.
/// It also handles the dismissal of the Weather SDK.
class WeatherViewModel: WeatherViewModelProtocol, AppStateProtocol {
    typealias ContentType = WeatherDetails

    // Published state property to notify the view of state changes (e.g., loading, success, error).
    @Published var state: AppState<WeatherDetails>
    
    // Stores the current weather details.
    var currentWeather: WeatherDisplayData?
    
    // Stores the weather forecast details.
    var weatherForecast: [WeatherDisplayData] = []
    
    // Weather service used to fetch weather data.
    let service: WeatherServiceProtocol
    
    /// Initializes the WeatherViewModel with the provided weather service.
    /// - Parameter service: The weather service used to fetch data.
    init(service: WeatherServiceProtocol) {
        self.service = service
        self.state = .idle
    }
    
    /// Fetches the current weather and forecast data asynchronously.
    /// Updates the state based on success, failure, or empty results.
    @MainActor
    func fetchWeatherData() async {
        self.state = .loading
        do {
            // Fetch current weather and forecast data asynchronously.
            async let currentWeatherTask: WeatherDisplayData? = loadCurrentWeather()
            async let weatherForecastTask: [WeatherDisplayData] =  loadWeatherForecast()
            
            // Wait for both tasks to finish and process the result.
            let (currentWeather, weatherForecast) = try await (currentWeatherTask, weatherForecastTask)
            
            // Create a weather details object and set the state accordingly.
            let weatherDetails = WeatherDetails(currentWeather: currentWeather, weatherForecast: weatherForecast)
            
            if weatherDetails.isEmpty {
                self.state = .empty
            } else {
                self.state = .success(weatherDetails)
            }
        } catch {
            self.state = .failed(error as? AppError ?? AppError.unknownError)
        }
    }
    
    /// Loads the current weather data from the service.
    /// - Returns: The current weather data or nil if an error occurs.
    private func loadCurrentWeather() async throws -> WeatherDisplayData? {
        return try await service.loadCurrentWeather()
    }
    
    /// Loads the weather forecast data from the service.
    /// - Returns: A list of weather forecast data.
    private func loadWeatherForecast() async throws -> [WeatherDisplayData] {
        return try await service.loadWeatherForecast()
    }
    
    /// Dismisses the Weather SDK and handles any errors if present.    
    func dismissSDK() {
        let extractedError: AppError? = {
            if case let .failed(error) = state {
                return error
            }
            return nil
        }()
        service.dismissWeatherSDK(error: extractedError)
    }
}
