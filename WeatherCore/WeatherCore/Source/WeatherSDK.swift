//
//  WeatherSDK.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation
import SwiftUI

/// A class responsible for interacting with the Weather SDK to fetch weather information.
///
/// This class manages the API key and provides a method to fetch weather data for a specific city.
/// It uses the provided `apiKey` to authenticate API requests.
public final class WeatherSDK {
    
    private let apiKey: String
    init (apiKey: String) {
        self.apiKey = apiKey
    }
    
    /// Returns the  view with the city weather details
    /// - Parameter city: name of city whch details to be feteched
    /// - Returns: View that show the details of the weather
    func getWeather(city: String) -> AnyView? {
        let viewModel: WeatherViewModel = WeatherViewModel()
        return AnyView(WeatherView(viewModel: viewModel))
    }
}
