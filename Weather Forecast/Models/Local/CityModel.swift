//
//  CityModel.swift
//  Weather Forecast
//
//  Created by 4steps on 02.05.23.
//

import Foundation

class CityModel: Codable{
    var name: String
    var country: String
    var coord: CoordCity
}

class CoordCity: Codable {
    var lat: Double
    var lon: Double
    
    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
}
