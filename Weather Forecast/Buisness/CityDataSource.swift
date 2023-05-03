//
//  CityDataSource.swift
//  Weather Forecast
//
//  Created by 4steps on 03.05.23.
//

import Foundation

class CityDataSource {
    
    var cities: [CityModel]?
    
    static let shared = CityDataSource()
    private init () {}
    
    func getCity() {
        let queue = DispatchQueue(label: "com.weahterForecast.getCity")
        queue.async(qos: .userInitiated) {
          CityManager.shared.getCity { [weak self] newCity in
              self?.cities = newCity
          }
       }
    }
}
