//
//  CityManager.swift
//  Weather Forecast
//
//  Created by 4steps on 02.05.23.
//

import Foundation

class CityManager {
    
    static let shared = CityManager()
    private init () {}

    func getCity(compelition: @escaping ([CityModel]) -> ()) {
        
        guard let path = Bundle.main.path(forResource: "city", ofType: "json") else { return }
       
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let object = try JSONDecoder().decode([CityModel].self, from: data)
            DispatchQueue.main.async {
                compelition(object)
            }
        } catch {
            print("Can't parse cities \(error.localizedDescription)")
        }
    }
}
