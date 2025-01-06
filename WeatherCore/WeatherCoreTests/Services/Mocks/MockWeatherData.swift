//
//  MockWeatherData.swift
//  WeatherCore
//
//  Created by Qazi on 05/01/2025.
//
import Foundation
@testable import WeatherCore

struct MockWeatherData {

    static func getDataForCurrentWeather() -> WeatherResponse {
        return getWeatherResponse(
            code: nil,
            data: [getWeatherData(skyCondition: "Cloud", weather: getWeather())],
            cityName: nil,
            countryCode: nil
        )
    }
    
    static func getDataForWeatherForecast() -> WeatherResponse {
        return getWeatherResponse(
            code: nil,
            data: [ getWeatherData(skyCondition: "Broken clouds", weather: getWeather()),
                    getWeatherData(skyCondition: "Overcast clouds", weather: getWeather())
                  ],
            cityName: "Berlin",
            countryCode: nil
        )
    }

    static func getWeatherResponse(
        code: Int? = 1,
        data: [WeatherData],
        cityName: String?,
        countryCode: Int?) -> WeatherResponse {
        WeatherResponse(count: code, data: data, cityName: nil, countryCode: nil)
    }
    
    static func getWeatherData(
        timestampLocal: String = "2010-12-23T12:34:56Z",
        cityName: String = "Berlin",
        countryCode: String = "GB",
        timestamp: Int = 1503936000,
        skyCondition: String,
        weather: Weather) -> WeatherData {
        WeatherData(
            timestampLocal: timestampLocal,
            appTemp: nil, aqi: nil,
            cityName: cityName, clouds: 0, countryCode: countryCode, datetime: timestampLocal,
            dewpt: nil, dhi: nil, dni: nil, elevAngle: nil, ghi: nil, gust: nil,
            hAngle: nil, lat: nil, lon: nil, obTime: nil, pod: "pod",
            precip: nil, pres: nil, rh: nil, slp: nil, snow: nil,
            solarRad: nil, sources: nil, stateCode: nil, station: nil,
            sunrise: nil, sunset: nil, temp: 23.0, timezone: nil,
            ts: timestamp, uv: nil, vis: nil,
            weather: getWeather(description: skyCondition),
            windCdir: "asd", windCdirFull: "adas", windDir: 12.4, windSpd: 123.0
        )
    }
    
    static func getWeather(
        code: Int = 2,
        description: String = "",
        icon: String = "") -> Weather {
        Weather(code: code, description: description, icon: icon)
    }
}
