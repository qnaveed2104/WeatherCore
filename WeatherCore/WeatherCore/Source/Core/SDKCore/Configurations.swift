//
//  Configurations.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

//// A struct that stores the settings needed to configure the WeatherSDK.
///
/// This struct contains important details like the API key, city name, and language
/// to make requests for weather information. It provides default values where applicable.
///
/// Example usage:
/// ```
/// let config = Configurations(apiKey: "your_api_key", cityName: "Berlin")
/// ```
public struct Configurations {
    /// The API key used to authenticate requests to the weather service (e.g., "Weatherbit").
    let apiKey: String
    
    /// The name of the city for which weather information will be fetched (e.g., "Berlin", "Munich").
    let cityName: String
    
    /// The language code for the response (e.g., "en" for English, "de" for German).
    /// Defaults to "en" if not provided.
    let language: String?
    
    /// The number of hours for which weather data is fetched. Defaults to 25.
    let hours: Int = 25
    
    /// Initializes a `Configurations` instance with the provided parameters.
    /// - Parameters:
    ///   - apiKey: The API key for authenticating requests.
    ///   - cityName: The name of the city to fetch weather details for.
    ///   - language: The response language. If not provided, defaults to "en".
    public init(apiKey: String, cityName: String, language: String = "en") {
        self.apiKey = apiKey
        self.cityName = cityName
        self.language = language
    }
}
