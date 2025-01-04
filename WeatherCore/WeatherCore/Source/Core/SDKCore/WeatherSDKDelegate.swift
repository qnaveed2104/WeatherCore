//
//  WeatherSDKDelegate.swift
//  WeatherCore
//
//  Created by Qazi on 04/01/2025.
//

import Foundation

public protocol WeatherSDKDelegate: AnyObject {
    func onFinished()
    func onFinishedWithError(_ error: Error)
}
