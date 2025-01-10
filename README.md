# WeatherCore

WeatherCore is a module designed to fetch, process, and present weather data within an iOS app. It integrates with external weather APIs to retrieve current weather data and weather forecasts, providing an abstraction layer for network calls, data decoding, and error handling.This project acts as a Debuging tool to create WeatherConnect.

## Overview

The `WeatherCore` module contains several components to fetch and process weather data. It includes protocols and implementations for handling API requests, decoding data, and managing errors. This allows for a clean and modular design where each component has a specific responsibility:

- **WeatherRepository**: Responsible for making network requests to fetch weather data using the provided `APIClient` and `WeatherRequestBuilder`.
- **APIClient**: Handles network communication, sending requests and decoding the responses.
- **Decoder**: Decodes the raw data into model objects or error messages.
- **WeatherViewModel**: Manages the state of weather data and communicates with the repository to fetch data.
- **WeatherView**: Displays weather data in a SwiftUI view.

## Topics

### WeatherRepository

The `WeatherRepository` is responsible for fetching weather data from a server. It uses `APIClient` to make network requests and a `WeatherRequestBuilder` to build the necessary requests.

- **Properties**:
  - `apiClient`: The `APIClientProtocol` used to make the API requests.
  - `requestBuilder`: The `WeatherRequestBuilderProtocol` used to build requests for current weather and weather forecast.

- **Methods**:
  - `fetchCurrentWeather`: Fetches the current weather data.
  - `fetchWeatherForcast`: Fetches the weather forecast data.

### APIClient

The `APIClient` is responsible for making asynchronous network requests to a server, fetching data, and decoding it. It adheres to the `APIClientProtocol`.

- **Properties**:
  - `decoder`: A `DecoderProtocol` used for decoding the response data.

- **Methods**:
  - `getDataFromServer`: Fetches data from the server and decodes the response into the specified model.

### Decoder

The `Decoder` is responsible for decoding the data fetched from the server. It adheres to the `DecoderProtocol`.

- **Methods**:
  - `decodeObject`: Decodes a `Decodable` object from the given data.
  - `decodeAPIError`: Decodes an API error message from the response data.

### WeatherViewModel

The `WeatherViewModel` is responsible for managing the state of the weather data and communicating with the repository to fetch the data. It is observed by the `WeatherView` to update the UI when new data is fetched.

- **Properties**:
  - `state`: The current state of the weather data (e.g., loading, success, failure).
  - `fetchWeather`: A method that fetches the weather data from the repository.

### WeatherView

The `WeatherView` is a SwiftUI view responsible for displaying the weather data to the user. It observes the `WeatherViewModel` for changes and updates the UI accordingly.

- **Components**:
  - `CurrentWeatherView`: Displays the current weather details.
  - `ForecastListView`: Displays the weather forecast for the next few days.
  - `backButton`: A custom back button to dismiss the view.

### AppError

`AppError` defines different types of errors that can occur within the WeatherCore module, including network errors, decoding errors, HTTP errors, and custom application-specific errors.

- **Error Types**:
  - `networkError`: Network-related issues, such as no internet connection.
  - `httpError`: Issues related to the HTTP response status.
  - `decodingError`: Errors during the decoding of response data.
  - `apiError`: API-specific errors, such as invalid responses or error messages returned by the server.

### Models

The following models are used to represent the data fetched from the weather API:

- `WeatherResponse`: Represents the weather data returned by the API, including details like temperature, humidity, and forecasts.

### WeatherRequestBuilder

The `WeatherRequestBuilder` is responsible for constructing the necessary `URLRequest` objects to interact with the weather API. It handles building requests for current weather and weather forecasts based on the API's requirements.

---

By organizing the WeatherCore module in this way, we ensure that each responsibility is decoupled and can be easily tested, modified, and extended.

