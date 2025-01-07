//
//  ContentView.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import SwiftUI

struct ClientAppContentView: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var isWeatherViewPresented = false // Track the modal presentation state
    var body: some View {
           NavigationStack {
               Button(action: {
                   // Trigger SDK-related logic here, if needed.
                   // Then, present WeatherView modally.
                   isWeatherViewPresented = true
               }, label: {
                   Text("Launch SDK")
               })
               .padding()
               
               // Present the weather view as a full-screen modal
               .fullScreenCover(isPresented: $isWeatherViewPresented, content: {
                   viewModel.getWeatherSDKView()
                       .edgesIgnoringSafeArea(.all) // Make sure the modal occupies the full screen
               })
           }
       }
}

#Preview {
    ClientAppContentView(viewModel: MainViewModel())
}
