//
//  CurrentWeatherModel.swift
//  HavaDurumu
//
//  Created by AHMET HAKAN YILDIRIM on 24.10.2022.
//

import Foundation

import UIKit

struct CurrentWeatherModel {
    
    let temperature : String
    let precipitationProbability: String
    let summary : String
    let humidity: String
    let icon: UIImage
    
    init(data:CurrentWeather) {
        self.temperature = "\(Int(data.temperature))°"
        self.precipitationProbability = "% \(data.precipProbability * 100)"
        self.summary = data.summary
        self.humidity = "%\(Int(data.humidity * 100))"
        self.icon = data.iconImage
    }
}
