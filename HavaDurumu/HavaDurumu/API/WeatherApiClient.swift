//
//  WeatherApiClient.swift
//  HavaDurumu
//
//  Created by AHMET HAKAN YILDIRIM on 26.10.2022.
//

import Foundation

class WeatherApiClient {
    
    fileprivate let apiKey = "apiKey"
   

    lazy var baseURL : URL = {
        return URL(string: "https://api.darksky.net/forecast/\(self.apiKey)/")!
    }()
    
    let downloader = JSONDownloader()
    
    typealias currentWeatherTypeCompletionHandler = (CurrentWeather?, WeatherApiError?)-> Void
    typealias weatherCompletionHandler = (Weather?, WeatherApiError?) -> Void
   private func gettWeather(at coordinate: Coordinate, completionHandler completion: @escaping weatherCompletionHandler) {
        guard let url = URL(string: coordinate.description, relativeTo: baseURL) else {
            completion(nil,WeatherApiError.invalidURL)
            return
        }
        let requestUrl = URLRequest(url: url)
        let task = downloader.jsonTask(with: requestUrl) { json, error in
            guard let json = json else {
                completion(nil , error!)
                return
            }
            
            guard let weather = Weather(json: json) else {
                completion(nil,WeatherApiError.jsonParsingError)
                return
            }
            
            completion(weather,nil)
        }
       task.resume()
    }
    
    func getCurrentWeather(at coordinate: Coordinate, completionHandler completion: @escaping currentWeatherTypeCompletionHandler){
        gettWeather(at: coordinate){ weather,error in
            completion(weather?.currently, error)
        }
    }
    
    
    
}
