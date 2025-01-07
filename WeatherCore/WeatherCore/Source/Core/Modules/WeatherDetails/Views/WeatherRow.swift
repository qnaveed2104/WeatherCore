//
//  WeatherRow.swift
//  WeatherCore
//
//  Created by Qazi on 06/01/2025.
//

import SwiftUI

struct WeatherRow: View {
    let forecast: WeatherDisplayData
    var body: some View {
        HStack {
           
            WeatherViewWithTheme(forecast.fomattedTime, style: .textRegular)
            WeatherViewWithTheme(forecast.formatedTemp, style: .title)
            WeatherViewWithTheme(forecast.skyCondition, style: .textRegular)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    WeatherRow(forecast: WeatherDisplayData(
        cityName: nil,
        formatedTemp: "20°C",
        fomattedTime: "16:00",
        skyCondition: "Clear")
    )
}
