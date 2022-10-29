//
//  JSONDownloader.swift
//  HavaDurumu
//
//  Created by AHMET HAKAN YILDIRIM on 26.10.2022.
//

import Foundation

class JSONDownloader {
    let session : URLSession
    
    init(config: URLSessionConfiguration) {
        self.session = URLSession(configuration: config)
    }
    
    convenience init() {
        self.init(config: URLSessionConfiguration.default)
    }
    
    typealias JSON = [String: AnyObject]
    func jsonTask(with request : URLRequest, completion: @escaping (JSON?, WeatherApiError?) -> Void) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil,WeatherApiError.requestError)
                return
            }
            
            if httpResponse.statusCode == 200 {
                
                if let data = data {
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON
                        completion(json,nil)
                    } catch  {
                        completion(nil,WeatherApiError.jsonParsingError)
                    }
                    
                }else {
                    
                    completion(nil,WeatherApiError.invalidData)
                }
                
            }else {
                // hata
                completion(nil, WeatherApiError.responseUnSuccessful(statusCode: httpResponse.statusCode))
            }
            
            
        }
        return task
    }
}
