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
            Text(forecast.fomattedTime)
                .font(.subheadline)
            Text(forecast.formatedTemp)
                .font(.subheadline)
            Text(forecast.skyCondition)
                .font(.subheadline)
        }
        .padding(.vertical, 4)
    }
}
