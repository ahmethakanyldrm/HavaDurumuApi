//
//  WeatherApiError.swift
//  HavaDurumu
//
//  Created by AHMET HAKAN YILDIRIM on 26.10.2022.
//

import Foundation

enum WeatherApiError {
    case requestError
    case responseUnSuccessful(statusCode:Int)
    case invalidData
    case jsonParsingError
    case invalidURL
}
