//
//  ContentView.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import SwiftUI

struct ClientAppContentView: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var weatherView: AnyView?
    var body: some View {
        NavigationStack {
            VStack {
                Button("Show Weather View") {
                    loadWeatherView()
                }
            }
            .navigationDestination(isPresented: $viewModel.isWeatherViewPresented) {
                if let weatherView = weatherView {
                    weatherView
                }
            }
        }
    }
    
    private func loadWeatherView() {
        Task {
            if let view = await viewModel.getWeatherView() {
                DispatchQueue.main.async {
                    self.weatherView = view
                    viewModel.isWeatherViewPresented = true
                }
            } else {
                print("Failed to load WeatherView")
            }
        }
    }
}

#Preview {
    ClientAppContentView(viewModel: MainViewModel())
}
