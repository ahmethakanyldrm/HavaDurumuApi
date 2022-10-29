//
//  Coordinate.swift
//  HavaDurumu
//
//  Created by AHMET HAKAN YILDIRIM on 26.10.2022.
//

import Foundation

struct Coordinate {
    let latitude: Double
    let longitude: Double
}

extension Coordinate: CustomStringConvertible {
    
    var description: String {
        return "\(latitude),\(longitude)"
    }
    
    static var alcatrazIsland : Coordinate {
        return Coordinate(latitude: 32.8267, longitude: -122.4233)
    }
    
}
