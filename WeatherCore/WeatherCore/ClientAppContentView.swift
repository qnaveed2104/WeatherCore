//
//  ContentView.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import SwiftUI

struct ClientAppContentView: View {
    @ObservedObject var viewModel: MainViewModel

    var body: some View {
        VStack {
            Text("Hello, world!")
            viewModel.getWeatherSDKView()
            
        }
        .padding()
    }
}

#Preview {
    ClientAppContentView(viewModel: MainViewModel())
}
